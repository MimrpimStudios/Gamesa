extends Node

class_name ResourceReloader

@onready var label: Label = $Label

@export_file_path("*.tscn") var scene: String

var rng = RandomNumberGenerator.new().randf_range(0.1, 1.0)
var rng2 = RandomNumberGenerator.new().randf_range(0.1, 0.5)
func _ready() -> void:
	label.text = "Loading patches..."
	load_patches()
	await get_tree().create_timer(rng).timeout
	label.text = "Checking for pumpkins..."
	kontrola_data()
	await get_tree().create_timer(rng).timeout
	label.text = "Printing some debug info..."
	await get_tree().create_timer(rng2).timeout
	print_loaded_resources()
	label.text = "Reloading resources..."
	await get_tree().create_timer(rng).timeout
	reload_all_resources()
	label.text = "Finalizing..."
	await get_tree().create_timer(rng).timeout
	get_tree().change_scene_to_file(scene)

func kontrola_data() -> void:
	var datum = Time.get_datetime_dict_from_system()
	var mesic: int = datum["month"]
	var den: int = datum["day"]

	var je_halloween = (mesic == 10 and den in [30, 31]) or (mesic == 11 and den == 1)

	if je_halloween:
		spustit_udalost()

func spustit_udalost() -> void:
	label.text = "Loading pumpkins..."
	var pck_path = "res://assets/pck/hw.pck"
	if ProjectSettings.load_resource_pack(pck_path):
		print("Sezónní PCK balíček byl úspěšně načten." + pck_path)
	else:
		printerr("Chyba: Nepodařilo se načíst PCK soubor z: ", pck_path)


# --- VEŘEJNÉ METODY ---

## Vytiskne přehled všech aktuálně načtených zdrojů v RAM a jejich typů.
func print_loaded_resources() -> void:
	var loaded = get_loaded_resources()
	print("\n=== SEZNAM NAČTENÝCH ZDROJŮ V RAM (%d) ===" % loaded.size())
	for path in loaded.keys():
		var instances: Array = loaded[path]
		if not instances.is_empty():
			var type_name = instances[0].get_class()
			print("- [%s] (%d instancí) -> %s" % [type_name, instances.size(), path])
	print("===========================================\n")


## Vyhledá všechny načtené zdroje v celém stromu scén.
func get_loaded_resources() -> Dictionary:
	var resources_map: Dictionary = {}
	var visited_ids: Dictionary = {}
	var visited_nodes: Dictionary = {}
	if get_tree() and get_tree().root:
		_scan_node_for_resources(get_tree().root, resources_map, visited_ids, visited_nodes)
	return resources_map


## Obnoví jeden konkrétní zdroj z disku
func reload_resource(res_path: String) -> Resource:
	if res_path.ends_with(".gd") or res_path.ends_with(".cs"):
		push_error("ResourceReloader: Skripty nelze takto reloadnout, použij reload current scene.")
		return null
	if res_path.ends_with(".tscn") or res_path.ends_with(".scn"):
		push_warning("ResourceReloader: PackedScene reload neaktualizuje již existující instance. Musíš je znovu instancovat.")
	
	if not FileAccess.file_exists(res_path):
		push_error("ResourceReloader: Soubor neexistuje: " + res_path)
		return null

	var new_res = ResourceLoader.load(res_path, "", ResourceLoader.CACHE_MODE_REPLACE)
	if not new_res:
		push_error("ResourceReloader: Nepodařilo se načíst: " + res_path)
		return null

	new_res.take_over_path(res_path)

	var loaded_map = get_loaded_resources()
	if not loaded_map.has(res_path):
		print("ResourceReloader: Zdroj '%s' načten, ale nebyl nalezen odkaz ve scéně." % res_path)
		return new_res

	var replace_map: Dictionary = {}
	for old_res in loaded_map[res_path]:
		if old_res != new_res:
			replace_map[old_res] = new_res

	var replaced_count = 0
	if not replace_map.is_empty():
		var visited_ids: Dictionary = {}
		var visited_nodes: Dictionary = {}
		replaced_count = _replace_in_node(get_tree().root, replace_map, visited_ids, visited_nodes)

	new_res.emit_changed()
	print("ResourceReloader: '%s' obnoven (%d referencí)." % [res_path, replaced_count])
	return new_res


## Obnoví VŠECHNY načtené zdroje
func reload_all_resources() -> void:
	var loaded_map = get_loaded_resources()
	if loaded_map.is_empty():
		print("ResourceReloader: Žádné zdroje k obnovení.")
		return

	print("ResourceReloader: Hromadný reload %d cest..." % loaded_map.size())

	var replace_map: Dictionary = {}
	var reloaded_count: int = 0

	for res_path in loaded_map.keys():
		# Přeskoč skripty a scény
		if res_path.ends_with(".gd") or res_path.ends_with(".tscn") or res_path.ends_with(".scn") or res_path.ends_with(".cs"):
			continue
		if not FileAccess.file_exists(res_path):
			continue

		var new_res = ResourceLoader.load(res_path, "", ResourceLoader.CACHE_MODE_REPLACE)
		if not new_res:
			continue

		new_res.take_over_path(res_path)
		reloaded_count += 1

		for old_res in loaded_map[res_path]:
			if old_res != new_res:
				replace_map[old_res] = new_res

	var total_replaced_refs: int = 0
	if not replace_map.is_empty():
		var visited_ids: Dictionary = {}
		var visited_nodes: Dictionary = {}
		total_replaced_refs = _replace_in_node(get_tree().root, replace_map, visited_ids, visited_nodes)
		
		for new_res in replace_map.values():
			if new_res is Resource:
				new_res.emit_changed()

	print("ResourceReloader: Hotovo. Obnoveno %d souborů, nahrazeno %d referencí." % [reloaded_count, total_replaced_refs])


# --- INTERNÍ METODY SKENOVÁNÍ ---

func _scan_node_for_resources(node: Node, map: Dictionary, visited_res: Dictionary, visited_nodes: Dictionary) -> void:
	if not node: return
	if visited_nodes.has(node.get_instance_id()): return
	visited_nodes[node.get_instance_id()] = true

	for prop in node.get_property_list():
		if prop["usage"] & PROPERTY_USAGE_READ_ONLY: continue
		if not (prop["usage"] & PROPERTY_USAGE_STORAGE): continue
		var val = node.get(prop["name"])
		_scan_value_for_resources(val, map, visited_res, visited_nodes)

	for child in node.get_children():
		_scan_node_for_resources(child, map, visited_res, visited_nodes)


func _scan_value_for_resources(val: Variant, map: Dictionary, visited_res: Dictionary, visited_nodes: Dictionary) -> void:
	if val is Resource:
		_register_resource(val, map, visited_res, visited_nodes)
	elif val is Array:
		for item in val:
			_scan_value_for_resources(item, map, visited_res, visited_nodes)
	elif val is Dictionary:
		for key in val.keys():
			_scan_value_for_resources(val[key], map, visited_res, visited_nodes)


func _register_resource(res: Resource, map: Dictionary, visited_res: Dictionary, visited_nodes: Dictionary) -> void:
	if not res: return
	var inst_id: int = res.get_instance_id()
	if visited_res.has(inst_id): return
	visited_res[inst_id] = true

	var path: String = res.resource_path
	if not path.is_empty():
		if not path.begins_with("res://"): return
		if not map.has(path):
			map[path] = []
		map[path].append(res)

	for prop in res.get_property_list():
		if prop["usage"] & PROPERTY_USAGE_READ_ONLY: continue
		if not (prop["usage"] & PROPERTY_USAGE_STORAGE): continue
		var val = res.get(prop["name"])
		_scan_value_for_resources(val, map, visited_res, visited_nodes)


# --- INTERNÍ METODY NAHRAZOVÁNÍ ---

func _replace_in_node(node: Node, replace_map: Dictionary, visited_res: Dictionary, visited_nodes: Dictionary) -> int:
	if not node: return 0
	if visited_nodes.has(node.get_instance_id()): return 0
	visited_nodes[node.get_instance_id()] = true

	var count: int = 0
	for prop in node.get_property_list():
		if prop["usage"] & PROPERTY_USAGE_READ_ONLY: continue
		if not (prop["usage"] & PROPERTY_USAGE_STORAGE): continue

		var prop_name: String = prop["name"]
		var val = node.get(prop_name)
		if val == null: continue

		var res_eval = _evaluate_and_replace(val, replace_map, visited_res, visited_nodes)
		if res_eval["changed"]:
			node.set(prop_name, res_eval["value"])
			count += res_eval["count"]

	for child in node.get_children():
		count += _replace_in_node(child, replace_map, visited_res, visited_nodes)

	return count


func _replace_in_resource(res: Resource, replace_map: Dictionary, visited_res: Dictionary, visited_nodes: Dictionary) -> int:
	if not res: return 0
	var inst_id: int = res.get_instance_id()
	if visited_res.has(inst_id): return 0
	visited_res[inst_id] = true

	var count: int = 0
	for prop in res.get_property_list():
		if prop["usage"] & PROPERTY_USAGE_READ_ONLY: continue
		if not (prop["usage"] & PROPERTY_USAGE_STORAGE): continue

		var prop_name: String = prop["name"]
		var val = res.get(prop_name)
		if val == null: continue

		var res_eval = _evaluate_and_replace(val, replace_map, visited_res, visited_nodes)
		if res_eval["changed"]:
			res.set(prop_name, res_eval["value"])
			count += res_eval["count"]

	return count


func _evaluate_and_replace(val: Variant, replace_map: Dictionary, visited_res: Dictionary, visited_nodes: Dictionary) -> Dictionary:
	var result = {"value": val, "changed": false, "count": 0}

	if val is Resource:
		if replace_map.has(val):
			result["value"] = replace_map[val]
			result["changed"] = true
			result["count"] += 1
		else:
			var sub_count = _replace_in_resource(val, replace_map, visited_res, visited_nodes)
			if sub_count > 0:
				result["changed"] = true
				result["count"] += sub_count

	elif val is Array:
		var arr = val
		var arr_changed = false
		for i in range(arr.size()):
			var item_eval = _evaluate_and_replace(arr[i], replace_map, visited_res, visited_nodes)
			if item_eval["changed"]:
				arr[i] = item_eval["value"]
				arr_changed = true
				result["count"] += item_eval["count"]
		if arr_changed:
			result["value"] = arr
			result["changed"] = true

	elif val is Dictionary:
		var dict = val
		var dict_changed = false
		for key in dict.keys():
			var val_eval = _evaluate_and_replace(dict[key], replace_map, visited_res, visited_nodes)
			if val_eval["changed"]:
				dict[key] = val_eval["value"]
				dict_changed = true
				result["count"] += val_eval["count"]
		if dict_changed:
			result["value"] = dict
			result["changed"] = true

	return result

func load_patches():
	print("loading patches...")
	load_all_patches()

func load_all_patches():
	# Určíme cestu ke složce "patches" vedle spustitelného souboru
	var patches_dir_path
	if OS.has_feature("editor"):
		patches_dir_path = "res://patches" # V editoru čte z projektu
	else:
		patches_dir_path = OS.get_executable_path().get_base_dir().path_join("patches")
	
	# Otevřeme adresář
	var dir = DirAccess.open(patches_dir_path)
	
	if dir:
		# Začneme číst obsah složky
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			# Ignorujeme samotný adresář a skryté soubory
			if !dir.current_is_dir():
				# Kontrola, zda soubor končí na .pck
				if file_name.get_extension().to_lower() == "pck" or file_name.get_extension().to_lower() == "zip":
					var full_path = patches_dir_path.path_join(file_name)
					
					# Načtení balíčku
					var success = ProjectSettings.load_resource_pack(full_path)
					
					if success:
						print("Úspěšně načten patch: ", file_name)
					else:
						push_error("Chyba při načítání patche: " + file_name)
						
			file_name = dir.get_next()
		
		dir.list_dir_end()
	else:
		print("Složka 'patches' nebyla nalezena na cestě: ", patches_dir_path)

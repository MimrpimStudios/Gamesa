extends Node

@export_file_path("*.tscn") var scene: String

func _ready() -> void:
	kontrola_data()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file(scene)

func kontrola_data() -> void:
	var datum = Time.get_datetime_dict_from_system()
	var mesic: int = datum["month"]
	var den: int = datum["day"]

	# Obalení do samostatných proměnných pro lepší čitelnost a jistotu priority operátorů
	var je_zari = (mesic == 9 and den in [7, 8, 9])
	var je_halloween = (mesic == 10 and den in [30, 31]) or (mesic == 11 and den == 1)

	if je_zari or je_halloween:
		spustit_udalost()

func spustit_udalost() -> void:
	var pck_path = "res://assets/pck/hw.pck"

	# load_resource_pack vrací bool – je dobré zkontrolovat, zda se balíček načetl
	if ProjectSettings.load_resource_pack(pck_path):
		print("Sezónní PCK balíček byl úspěšně načten.")
	else:
		printerr("Chyba: Nepodařilo se načíst PCK soubor z: ", pck_path)

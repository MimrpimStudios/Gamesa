extends Node

const PORT = 7000
const PLAYER_SCENE = preload("res://scenes/player.tscn") # Uprav si cestu ke své scéně hráče, pokud je jiná

func host_game():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT)
	if error != OK:
		print("Chyba při vytváření serveru: ", error)
		return
		
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	
	print("Server úspěšně založen!")
	
	# Host se po založení serveru přepne do prvního levelu (nebo na úvodní příběh)
	call_deferred("_load_game_scene", global_var.house_00_story_scene)

func join_game(ip: String):
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip, PORT)
	if error != OK:
		print("Chyba při připojování: ", error)
		return
		
	multiplayer.multiplayer_peer = peer
	print("Připojuji se k serveru na IP: ", ip)
	
	# Klient se také přepne do levelu (server ho pak dospawnuje)
	call_deferred("_load_game_scene", global_var.house_00_story_scene)

func _load_game_scene(scene_path: String):
	get_tree().change_scene_to_file(scene_path)
	# Počkej chvíli, než se scéna načte, a pak vytvoř lokálního hráče
	await get_tree().process_frame
	_spawn_local_player()

func _on_player_connected(id):
	print("Hráč se připojil s ID: ", id)
	# Když se připojí nový hráč, server pro něj vytvoří instanci hráče v aktuální scéně
	if multiplayer.is_server():
		_spawn_remote_player(id)

func _on_player_disconnected(id):
	print("Hráč se odpojil: ", id)
	var player_node = get_tree().current_scene.get_node_or_null(str(id))
	if player_node:
		player_node.queue_free()

func _spawn_local_player():
	var my_id = multiplayer.get_unique_id()
	var current_scene = get_tree().current_scene
	
	if current_scene and not current_scene.has_node(str(my_id)):
		var player = PLAYER_SCENE.instantiate()
		player.name = str(my_id) # Jméno uzlu MUSÍ být ID hráče kvůli MultiplayerSynchronizeru!
		current_scene.add_child(player)

func _spawn_remote_player(id: int):
	var current_scene = get_tree().current_scene
	if current_scene and not current_scene.has_node(str(id)):
		var player = PLAYER_SCENE.instantiate()
		player.name = str(id)
		current_scene.add_child(player)

extends Node2D

@onready var mimrpim_studios: Sprite2D = $Player/MimrpimStudios
@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = %Camera2D
@onready var label: Label = $Player/Label
@onready var collision_shape_2d: CollisionShape2D = $Player/CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

const DRUM_LOOP = preload("uid://bhwbubaca3864")

var camera = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	mimrpim_studios.hide()
	label.hide()
	if global_var.intro_play:
		await get_tree().create_timer(3).timeout
		mimrpim_studios.show()
		await get_tree().create_timer(3).timeout
		mimrpim_studios.hide()
		await get_tree().create_timer(1.5).timeout
		
		player.direction = 1
		await get_tree().create_timer(2.8).timeout
		player.jump()
		await get_tree().create_timer(0.3).timeout
		player.jump_off()
		await get_tree().create_timer(0.12).timeout
		player.direction = 0
		await get_tree().create_timer(1.5).timeout
		label.show()
		await get_tree().create_timer(1.5).timeout
		label.hide()
		await get_tree().create_timer(3).timeout
		
		player.direction = 1
		player.jump()
		await get_tree().create_timer(0.3).timeout
		player.jump_off()
		await get_tree().create_timer(2.8).timeout
		player.jump()
		await get_tree().create_timer(0.3).timeout
		player.jump_off()
		await get_tree().create_timer(0.12).timeout
		player.direction = 0
		await get_tree().create_timer(1.5).timeout
		label.set_text("By Mimrpim")
		label.show()
		await get_tree().create_timer(3).timeout
		label.hide()
		await get_tree().create_timer(1.5).timeout
		collision_shape_2d.queue_free()
		camera = false
		await get_tree().create_timer(1.5).timeout
		global_var.player_health = 0
		global_var.intro_play = false
	else:
		audio_stream_player.stop()
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file(global_var.main_scene)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if camera:
		camera_2d.global_position = player.global_position


func _on_audio_stream_player_finished() -> void:
	audio_stream_player.stream = DRUM_LOOP
	audio_stream_player.play()

func _input(event):
	# Zkontrolujeme, jestli jde o stisk klávesy (a ne o pohyb myši apod.)
	# event.is_pressed() zajistí, že kód proběhne jen při zmáčknutí, ne při puštění klávesy
	if event is InputEventKey and event.is_pressed():
		
		# Zde definujeme seznam fyzických kláves, které chceme ignorovat
		var ignorovane_klavesy = [
			KEY_VOLUMEUP,
			KEY_VOLUMEDOWN,
			KEY_VOLUMEMUTE,
			KEY_MEDIANEXT,
			KEY_MEDIAPREVIOUS,
			KEY_MEDIAPLAY,
			KEY_MEDIASTOP
		]
		
		# Pokud je zmáčknutá klávesa v našem seznamu ignorovaných, ukončíme funkci
		if event.physical_keycode in ignorovane_klavesy:
			return
			
		# ---- TADY UŽ MŮŽEŠ DĚLAT COKOLIV CHCEŠ ----
		print("Byla zmáčknuta platná klávesa: ", event.as_text())
		_moje_akce()

func _moje_akce():
	# Zde bude tvůj kód, který se má spustit
	get_tree().change_scene_to_file(global_var.main_scene)

extends Control

@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1).timeout
	audio_stream_player.play()
	video_stream_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_video_stream_player_finished() -> void:
	_moje_akce()

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
	video_stream_player.paused = true
	video_stream_player.hide()
	audio_stream_player.stream_paused = true
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file(global_var.main_menu_scene)

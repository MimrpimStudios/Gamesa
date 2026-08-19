extends Control

@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	await get_tree().create_timer(5).timeout
	video_stream_player.play()
	audio_stream_player.play()
	global_var.level = "res://scenes/post/label1.tscn"
	global_var.save_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_video_stream_player_finished() -> void:
	await get_tree().create_timer(1).timeout
	if global_var.credits_true:
		get_tree().change_scene_to_file(global_var.cicada_scene)
	else:
		get_tree().change_scene_to_file(global_var.main_menu_scene)

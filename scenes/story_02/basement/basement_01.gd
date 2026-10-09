extends Node2D

const SEWERS_LOOP = preload("uid://dluyyx0kkx54q")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_var.player_movement = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	global_var.level = get_tree().current_scene.scene_file_path
	global_var.save_level_story_2()
	if not SewersMusic.stream == SEWERS_LOOP or not SewersMusic.playing:
		SewersMusic.stream = SEWERS_LOOP
		SewersMusic.play()
		SewersMusic.pitch_scale = 0.25
	if not SewersMusic.pitch_scale == 0.25:
		SewersMusic.pitch_scale = 0.25

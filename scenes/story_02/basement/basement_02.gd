extends Node2D

const SEWERS_LOOP = preload("uid://dluyyx0kkx54q")

@onready var camera_2d: PhantomCamera2D = $Player/Camera2D
@onready var camera_2d2: PhantomCamera2D = $Camera2D
@onready var camera_2d_3: PhantomCamera2D = $Camera2D3
@onready var camera_2_zoom: PhantomCamera2D = $Player/Camera2Dzoom

@onready var player: CharacterBody2D = $Player
@onready var dialog_player: Label = $Player/DialogPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_var.player_movement = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	global_var.level = get_tree().current_scene.scene_file_path
	global_var.save_level_story_2()
	if not SewersMusic.stream == SEWERS_LOOP or not SewersMusic.playing:
		SewersMusic.stream = SEWERS_LOOP
		SewersMusic.play()
		SewersMusic.pitch_scale = 0.25
	if not SewersMusic.pitch_scale == 0.25:
		SewersMusic.pitch_scale = 0.25

	await get_tree().create_timer(1).timeout
	camera_2_zoom.priority = 1
	camera_2d.priority = 0

	await get_tree().create_timer(3).timeout
	dialog_player.text = "So, what now?"
	await get_tree().create_timer(2.5).timeout
	dialog_player.text = ""
	await get_tree().create_timer(0.5).timeout
	await get_tree().create_timer(3).timeout
	camera_2_zoom.priority = 0
	camera_2d_3.priority = 1
	await get_tree().create_timer(3).timeout
	dialog_player.text = "Oh..."
	await get_tree().create_timer(1.5).timeout
	dialog_player.text = ""
	camera_2d2.priority = 5
	await get_tree().create_timer(1).timeout
	global_var.player_movement = true

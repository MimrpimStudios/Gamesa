extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody2D = $Player
@onready var player_anim: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var mother: CharacterBody2D = $Mother
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var color_rect: ColorRect = $ColorRect
@onready var audio_player: AudioStreamPlayer2D = $Player/AudioPlayer

# Called when the node enters the scene tree for the first time.
@onready var dialog_player: Label = $Player/DialogPlayer
@onready var dialog_mother: Label = $Mother/DialogMother

const GAMING_PC_WARCRAFT_END = preload("uid://4650g4k40inh")
const GAMING_PC_WARCRAFT_LOOP = preload("uid://id58uss8xrlv")
const GAMING_PC_WARCRAFT_START = preload("uid://ddgtdflsiu5lv")

# Player dialogs

var sfx_loop_end = false

func _ready() -> void:
	color_rect.show()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	global_var.level = get_tree().current_scene.scene_file_path
	global_var.save_level()
	await get_tree().create_timer(0.1).timeout
	global_var.player_movement = false
	animation_player.play("story")
	player_anim.play("sitting")
	player.position = Vector2(540.0, 307.0)
	animation_player.play("fade 1")
	await animation_player.animation_finished
	animation_player.play("story")
	story_01()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func story_01():
	player_anim.play("sitting")
	await get_tree().create_timer(3).timeout
	dialog_player.text = "Go, paladin go!".to_upper()
	await get_tree().create_timer(3).timeout
	dialog_player.text = ""
	await get_tree().create_timer(1).timeout
	dialog_mother.text = "Gam, can you come here, please?".to_upper()
	await get_tree().create_timer(4.5).timeout
	dialog_mother.text = ""
	await get_tree().create_timer(1).timeout
	sfx_loop_end = true
	dialog_player.text = "One second...".to_upper()
	await get_tree().create_timer(2).timeout
	dialog_player.text = ""
	while audio_stream_player_2d.stream == GAMING_PC_WARCRAFT_LOOP:
		await get_tree().create_timer(2).timeout
	await audio_stream_player_2d.finished
	global_var.player_movement = true
	player.sit = false
	await get_tree().create_timer(1).timeout
	player.direction = -1
	await get_tree().create_timer(0.9).timeout
	player.direction = 0
	await get_tree().create_timer(1.5).timeout
	dialog_mother.text = "Listen cearfuly...\nI need you to go to the\n pharmacy in the town...".to_upper()
	await get_tree().create_timer(8).timeout
	dialog_mother.text = ""
	await get_tree().create_timer(0.5).timeout
	dialog_mother.text = "and get some pills.".to_upper()
	await get_tree().create_timer(3).timeout
	dialog_mother.text = ""
	mother.anim = "sleep_start"
	mother.preview()
	await get_tree().create_timer(0.5).timeout
	dialog_mother.text = "Okay?".to_upper()
	await get_tree().create_timer(3).timeout
	dialog_mother.text = ""
	await get_tree().create_timer(0.5).timeout
	await get_tree().create_timer(3).timeout
	animation_player.play("fade 2")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(global_var.house_01_scene)


func _on_audio_stream_player_2d_finished() -> void:
	if audio_stream_player_2d.stream == GAMING_PC_WARCRAFT_START:
		audio_stream_player_2d.stream = GAMING_PC_WARCRAFT_LOOP
		audio_stream_player_2d.play()
	elif sfx_loop_end and audio_stream_player_2d.stream == GAMING_PC_WARCRAFT_LOOP:
		audio_stream_player_2d.stream = GAMING_PC_WARCRAFT_END
		audio_stream_player_2d.play()
	elif audio_stream_player_2d.stream == GAMING_PC_WARCRAFT_LOOP:
		audio_stream_player_2d.play()

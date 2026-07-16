extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody2D = $Player
@onready var player_anim: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var mother: CharacterBody2D = $Mother
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var color_rect: ColorRect = $ColorRect
@onready var audio_player: AudioStreamPlayer2D = $Player/AudioPlayer
@onready var label: Label = $CanvasLayer/Label

# Called when the node enters the scene tree for the first time.
@onready var dialog_player: Label = $Player/DialogPlayer
@onready var dialog_mother: Label = $Mother/DialogMother

const GAMING_PC_WARCRAFT_END = preload("uid://4650g4k40inh")
const GAMING_PC_WARCRAFT_LOOP = preload("uid://id58uss8xrlv")
const GAMING_PC_WARCRAFT_START = preload("uid://ddgtdflsiu5lv")

# Player dialogs


func _ready() -> void:
	label.hide()
	color_rect.show()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	global_var.level = get_tree().current_scene.scene_file_path
	global_var.save_level()
	await get_tree().create_timer(0.1).timeout
	global_var.player_movement = true
	animation_player.play("story")
	player_anim.play("sitting")
	animation_player.play("fade 1")
	await animation_player.animation_finished
	animation_player.play("story")
	story_02()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func story_02():
	await get_tree().create_timer(1).timeout
	player.direction = -1
	await get_tree().create_timer(0.9).timeout
	player.direction = 0
	await get_tree().create_timer(1).timeout
	dialog_player.set_text("Mom, I am back and I have\nThe pills!".to_upper())
	await get_tree().create_timer(4.5).timeout
	dialog_player.set_text("")
	await get_tree().create_timer(1).timeout
	mother.anim = "fake_sleep"
	mother.preview()
	await get_tree().create_timer(1).timeout
	dialog_mother.text = "Oh that is awsome...\nGive it to me...".to_upper()
	await get_tree().create_timer(2.3).timeout
	mother.anim = "stand"
	mother.preview()
	await get_tree().create_timer(3.2).timeout
	animation_player.play("fade 2 fake")
	await get_tree().create_timer(1.5).timeout
	dialog_mother.text = "".to_upper()
	await animation_player.animation_finished
	await get_tree().create_timer(1.5).timeout
	dialog_mother.text = "Now I am\nfealing much better...\n Thank you son!".to_upper()
	await get_tree().create_timer(4.5).timeout
	dialog_mother.text = "".to_upper()
	await get_tree().create_timer(1).timeout
	animation_player.play("fade 2")
	await animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(global_var.house_02_in_scene)


func _on_audio_stream_player_2d_finished() -> void:
	pass

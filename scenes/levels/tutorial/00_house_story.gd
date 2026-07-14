extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody2D = $Player
@onready var player_anim: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var mother: CharacterBody2D = $Mother

# Called when the node enters the scene tree for the first time.
@onready var dialog_player: Label = $Player/DialogPlayer
@onready var dialog_mother: Label = $Mother/DialogMother

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	global_var.level = get_tree().current_scene.scene_file_path
	global_var.save_level()
	await get_tree().create_timer(0.1).timeout
	global_var.player_movement = false
	animation_player.play("story")
	player_anim.play("sitting")
	player.position = Vector2(540.0, 310.0)
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
	dialog_player.text = "Die you Wretches...".to_upper()
	await get_tree().create_timer(3).timeout
	dialog_player.text = ""
	await get_tree().create_timer(1).timeout
	dialog_mother.text = "Son, can you come here, please?".to_upper()
	await get_tree().create_timer(4.5).timeout
	dialog_mother.text = ""
	await get_tree().create_timer(1).timeout
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
	dialog_mother.text = "Okey?".to_upper()
	await get_tree().create_timer(3).timeout
	dialog_mother.text = ""
	await get_tree().create_timer(0.5).timeout
	await get_tree().create_timer(3).timeout
	animation_player.play("fade 2")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(global_var.house_01_scene)

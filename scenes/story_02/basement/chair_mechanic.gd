extends Node

@onready var player: CharacterBody2D = $"../Player"

@onready var player_animated_sprite_2d: AnimatedSprite2D = $"../Player/AnimatedSprite2D"
@onready var sprite_2d: Sprite2D = $Sprite2D

const PLAYER_ROPE_CHAIR_BROKEN = preload("uid://c3y05odf08dpn")

var jump_count: int = 0
func _ready() -> void:
	await get_tree().process_frame
	global_var.player_movement = false

func _physics_process(_delta: float) -> void:
	if not global_var.player_movement:
		player.hide()
		player.position = Vector2(8.0, -10.0)
		player_animated_sprite_2d.animation = "sitting_couch"
		

func _input(_event: InputEvent) -> void:
	if not jump_count == 5:
		if Input.is_action_just_pressed("jump"):
			jump_count += 1
	else:
		await get_tree().process_frame
		global_var.player_movement = true
		player.show()
		sprite_2d.set_texture(PLAYER_ROPE_CHAIR_BROKEN)

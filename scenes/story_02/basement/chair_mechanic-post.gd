extends Node

@onready var player: CharacterBody2D = $"../Player"

@onready var player_animated_sprite_2d: AnimatedSprite2D = $"../Player/AnimatedSprite2D"
@onready var sprite_2d: Sprite2D = $Sprite2D

const PLAYER_ROPE_CHAIR_BROKEN = preload("uid://c3y05odf08dpn")

var jump_count: int = 0
func _ready() -> void:
	await get_tree().process_frame
	global_var.player_movement = true
	sprite_2d.set_texture(PLAYER_ROPE_CHAIR_BROKEN)

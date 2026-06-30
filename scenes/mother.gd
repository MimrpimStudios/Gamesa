extends CharacterBody2D

@export_enum("stand", "left", "right", "sleep_start", "sleeping") var anim: String = "stand"
@export var flip_h: bool
@export var flip_v: bool
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.play(anim)
	animated_sprite_2d.flip_h = flip_h
	animated_sprite_2d.flip_v = flip_v

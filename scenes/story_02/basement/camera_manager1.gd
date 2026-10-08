extends Node

@onready var thief: CharacterBody2D = $"../Thief"
@onready var thief_2: CharacterBody2D = $"../Thief2"
@onready var thief_animated_sprite_2d: AnimatedSprite2D = $"../Thief/AnimatedSprite2D"
@onready var thief_2_animated_sprite_2d: AnimatedSprite2D = $"../Thief2/AnimatedSprite2D"

@onready var _1_area_2d: Area2D = $"../Thief/1Area2D"
@onready var _1_area_2d_2: Area2D = $"../Thief/1Area2D2"

@onready var _2_area_2d: Area2D = $"../Thief2/2Area2D"
@onready var _2_area_2d_2: Area2D = $"../Thief2/2Area2D2"
@onready var _2_area_2dall: Area2D = $"../Thief2/2Area2DALL"

var rotation: bool = false # false left and right true right and left
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if rotation:
		thief_animated_sprite_2d.animation = "left"
		thief_animated_sprite_2d.frame = 1
		_1_area_2d.monitoring = true
		_1_area_2d_2.monitoring = false
		_2_area_2d.monitoring = false
		_2_area_2d_2.monitoring = true
		_2_area_2dall.monitoring = true

		thief_2_animated_sprite_2d.animation = "right"
		thief_2_animated_sprite_2d.frame = 1
	else:
		thief_animated_sprite_2d.animation = "right"
		thief_animated_sprite_2d.frame = 1
		_1_area_2d.monitoring = false
		_1_area_2d_2.monitoring = true

		_2_area_2d.monitoring = true
		_2_area_2d_2.monitoring = false
		_2_area_2dall.monitoring = true
		thief_2_animated_sprite_2d.animation = "left"
		thief_2_animated_sprite_2d.frame = 1


func _on_timer_timeout() -> void:
	rotation = not rotation

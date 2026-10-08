extends Node

@onready var thief: CharacterBody2D = $"../Thief"
@onready var thief_2: CharacterBody2D = $"../Thief2"
@onready var thief_animated_sprite_2d: AnimatedSprite2D = $"../Thief/AnimatedSprite2D"
@onready var thief_2_animated_sprite_2d: AnimatedSprite2D = $"../Thief2/AnimatedSprite2D"

var rotation: bool = false # false left true right
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if rotation:
		thief_animated_sprite_2d.animation = "left"
		thief_animated_sprite_2d.frame = 1
		thief_2_animated_sprite_2d.animation = "left"
		thief_2_animated_sprite_2d.frame = 1
	else:
		thief_animated_sprite_2d.animation = "right"
		thief_animated_sprite_2d.frame = 1
		thief_2_animated_sprite_2d.animation = "right"
		thief_2_animated_sprite_2d.frame = 1


func _on_timer_timeout() -> void:
	rotation = not rotation

extends Node2D

@onready var thief_animated_sprite_2d: AnimatedSprite2D = $Thief/AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	thief_animated_sprite_2d.speed_scale = 1.5
	thief_animated_sprite_2d.animation = "left"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

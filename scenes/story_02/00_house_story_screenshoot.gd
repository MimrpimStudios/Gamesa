extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $Player/AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	animated_sprite_2d.animation = "sleep"
# Called every frame. 'delta' is the elapsed time since the previous frame.

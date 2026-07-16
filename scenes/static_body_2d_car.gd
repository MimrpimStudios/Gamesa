extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if animated_sprite_2d.frame == 0:
		position = Vector2(0.0, 0.0)
	else:
		position = Vector2(0.0, -1.0)

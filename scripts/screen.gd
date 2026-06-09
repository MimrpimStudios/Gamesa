extends CanvasLayer

@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation.play("saving")

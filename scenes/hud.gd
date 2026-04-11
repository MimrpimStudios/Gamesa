extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.action_release("down")
	Input.action_release("jump")
	Input.action_release("left")
	Input.action_release("right")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

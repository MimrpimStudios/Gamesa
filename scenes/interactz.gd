extends Button


# Called when the node enters the scene tree for the first time.


func _on_pressed() -> void:
	Input.action_press("integrate", 1)
	Input.action_release("integrate")

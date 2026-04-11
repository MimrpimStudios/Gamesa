extends Button


# Called when the node enters the scene tree for the first time.



func _on_button_up() -> void:
	Input.action_release("jump")


func _on_button_down() -> void:
	Input.action_press("jump", 1)

extends Node


func _on_right_pressed() -> void:
	simulate_key_press(KEY_E)


func _on_left_pressed() -> void:
	simulate_key_press(KEY_A)


func _on_jump_pressed() -> void:
	pass # Replace with function body.


func _on_use_pressed() -> void:
	pass # Replace with function body.


func _on_pause_pressed() -> void:
	pass # Replace with function body.


func _on_right_released() -> void:
	pass # Replace with function body.


func _on_left_released() -> void:
	pass # Replace with function body.


func _on_jump_released() -> void:
	pass # Replace with function body.

func simulate_key_press(keycode: Key):
	# 1. Vytvoření události pro stisknutí (Press)
	var event_down = InputEventKey.new()
	event_down.keycode = keycode  # V Godot 3 použijte 'scancode' namísto 'keycode'
	event_down.pressed = true
	Input.parse_input_event(event_down)

	# 2. Vytvoření události pro uvolnění (Release)
	var event_up = InputEventKey.new()
	event_up.keycode = keycode    # V Godot 3 použijte 'scancode' namísto 'keycode'
	event_up.pressed = false
	Input.parse_input_event(event_up)	

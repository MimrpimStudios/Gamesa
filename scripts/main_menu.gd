extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_texture_button_play_pressed() -> void:
	global_var.level = global_var.load_level()
	print(global_var.level)
	get_tree().change_scene_to_file(global_var.level)


func _on_texture_button_exit_pressed() -> void:
	if not global_var.load_level() == null:
		print(global_var.level)
		global_var.save_level()
	get_tree().quit(0)

extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global_var.enabled_story_2:
		for i in get_children():
			i.show()
	else:
		for i in get_children():
			i.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(global_var.story_2_main_menu_scene)

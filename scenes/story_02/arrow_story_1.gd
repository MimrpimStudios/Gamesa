extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		i.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(global_var.main_menu_scene)

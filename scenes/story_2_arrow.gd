extends Node

@onready var button: TextureButton = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global_var.load_is_story_2():
		for i in get_children():
			i.show()
	else:
		for i in get_children():
			i.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(global_var.story_2_main_menu_scene)


func _on_button_focus_entered() -> void:
	button.position.x = 1800



func _on_button_focus_exited() -> void:
	button.position.x = 1796


func _on_button_mouse_entered() -> void:
	button.position.x = 1800


func _on_button_mouse_exited() -> void:
	button.position.x = 1796

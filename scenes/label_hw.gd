extends Label

@onready var color_rect: ColorRect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.hide()
	if global_var.is_hw:
		show()
	else:
		hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	color_rect.show()

func _on_mouse_exited() -> void:
	color_rect.hide()

func _input(_event: InputEvent) -> void:
	if color_rect.visible and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		global_var.hw_enabled = false
		ProjectSettings.load_resource_pack(OS.get_executable_path().get_base_dir() + "/gamesa.pck")
		print("loaded ", OS.get_executable_path().get_base_dir() + "/gamesa.pck")
		get_tree().change_scene_to_file("res://scenes/preload.tscn")

extends Label

@onready var color_rect: ColorRect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	color_rect.show()

func _on_mouse_exited() -> void:
	color_rect.hide()

func _input(_event: InputEvent) -> void:
	if color_rect.visible and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		global_var.intro_play = true
		get_tree().change_scene_to_file(global_var.credits_scene)

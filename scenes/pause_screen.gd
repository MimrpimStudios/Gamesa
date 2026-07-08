extends CanvasLayer

@onready var tree = get_tree()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if visible:
		get_tree().paused = true
	else:
		get_tree().paused = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		# Bezpečně zkontrolujeme, zda scéna existuje a zda nejsme v menu
		if tree.current_scene and not tree.current_scene.scene_file_path in global_var.menus:
			# Překlopí viditelnost (pokud je true, bude false a naopak)
			if not visible:
				visible = true
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				visible = false
				Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _on_continue_pressed() -> void:
	visible = false


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file(global_var.main_menu_scene)
	visible = false

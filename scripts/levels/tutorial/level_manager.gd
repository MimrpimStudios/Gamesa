extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_var.player_movement = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("esc"):
		get_tree().change_scene_to_file(global_var.main_menu_scene)

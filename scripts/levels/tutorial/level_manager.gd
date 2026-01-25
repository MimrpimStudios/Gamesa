extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_var.player_movement = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print("changing scene to: " + global_var.house_01_scene)
	get_tree().change_scene_to_file(global_var.house_01_scene)

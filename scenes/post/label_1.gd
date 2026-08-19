extends Label

@export var time: float = 1
@export_file_path("*.tscn") var scene: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_var.level = scene
	global_var.save_level()
	await get_tree().create_timer(time).timeout
	get_tree().change_scene_to_file(global_var.main_scene)

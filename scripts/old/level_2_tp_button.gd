extends Button

const level_2_old = "res://scenes/Levels/old/level_2.tscn"
func _on_pressed() -> void:
	get_tree().change_scene_to_file(level_2_old)

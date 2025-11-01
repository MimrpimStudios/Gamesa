extends Button

const Level2_scene = "res://scenes/Levels/level_2.tscn"
func _on_pressed() -> void:
	print("[DEBUG/MAIN] Pressed Level2tp button")
	print("[INFO/MAIN] Starting scene" + Level2_scene)
	get_tree().change_scene_to_file(Level2_scene)

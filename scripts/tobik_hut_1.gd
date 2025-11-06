extends Node2D

const tutorial_1_scene = "res://scenes/Levels/Tutorial1/Tutorial1_outdoor_hut_exit.tscn"

func _on_tobik_hut_button_pressed() -> void:
	get_tree().change_scene_to_file(tutorial_1_scene)

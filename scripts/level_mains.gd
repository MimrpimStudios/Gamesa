extends Node2D

const MainMenu_scene = "res://scenes/MainMenu/MainMenu.tscn"
const tutorial1_out_scene = "res://scenes/Levels/Tutorial1/Tutorial1_outdoor.tscn"
const tutorial1_house_scene = "res://scenes/Levels/Tutorial1/Tutorial1_house.tscn"

func _input(event):
	if Input.is_action_just_pressed("esc"):
		print("[DEBUG/MAIN] Pressed "+str(event)+" button")
		print("[INFO/MAIN] Starting scene" + MainMenu_scene)
		get_tree().change_scene_to_file(MainMenu_scene)

func _on_house_button_pressed() -> void:
	get_tree().change_scene_to_file(tutorial1_house_scene)


func _on_house_door_button_pressed() -> void:
	get_tree().change_scene_to_file(tutorial1_out_scene)

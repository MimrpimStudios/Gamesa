extends Node2D

const MainMenu_scene = "res://scenes/MainMenu/MainMenu.tscn"

func _input(event):
	if Input.is_action_just_pressed("esc"):
		print("[DEBUG/MAIN] Pressed Escape button")
		print("[INFO/MAIN] Starting scene" + MainMenu_scene)
		get_tree().change_scene_to_file(MainMenu_scene)

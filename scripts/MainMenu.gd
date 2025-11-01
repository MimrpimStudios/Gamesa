extends Control

@onready var PlayButton = $PlayButton
@onready var ExitButton = $ExitButton
@onready var music = $AudioStreamPlayer

const start_scene = "res://scenes/main.tscn"

func _ready() -> void:
	print("[INFO/MAIN_MENU] Playing music")
	music.play()

func _on_play_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Play button")
	print("[INFO/MAIN_MENU] Starting scene" + start_scene)
	get_tree().change_scene_to_file(start_scene)

func _on_exit_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Exit button")
	print("[INFO/MAIN_MENU] Exiting the game")
	get_tree().quit()

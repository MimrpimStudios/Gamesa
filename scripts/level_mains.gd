extends Node2D

const MainMenu_scene = "res://scenes/MainMenu/MainMenu.tscn"
const tutorial1_out_scene = "res://scenes/Levels/Tutorial1/Tutorial1_outdoor.tscn"
const tutorial1_house_scene = "res://scenes/Levels/Tutorial1/Tutorial1_house.tscn"
var repeat_house = false
var repeat_house_in = false

func _input(event):
	if Input.is_action_just_pressed("esc"):
		print("[DEBUG/MAIN] Pressed "+str(event)+" button")
		print("[INFO/MAIN] Starting scene" + MainMenu_scene)
		get_tree().change_scene_to_file(MainMenu_scene)

func _on_house_button_pressed() -> void:
	get_tree().change_scene_to_file(tutorial1_house_scene)

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	print(str(body))
	repeat_house = false


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	print(str(body))
	repeat_house = true

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and repeat_house:
		get_tree().change_scene_to_file(tutorial1_house_scene)
	if Input.is_action_just_pressed("interact") and repeat_house_in:
		get_tree().change_scene_to_file(tutorial1_out_scene)


func _on_house_door_in_button_pressed() -> void:
	get_tree().change_scene_to_file(tutorial1_out_scene)


func _on_door_house_area_body_entered(body: Node2D) -> void:
	print(str(body))
	repeat_house_in = true


func _on_door_house_area_body_exited(body: Node2D) -> void:
	print(str(body))
	repeat_house_in = false

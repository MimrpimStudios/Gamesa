extends Node2D

const tutorial1_town_scene = "res://scenes/Levels/Tutorial1/Tutorial1_town.tscn"
const MainMenu_scene = "res://scenes/MainMenu/MainMenu.tscn"
const tutorial1_out_scene = "res://scenes/Levels/Tutorial1/Tutorial1_outdoor.tscn"
const tutorial1_house_scene = "res://scenes/Levels/Tutorial1/Tutorial1_house.tscn"
const SAVE_PATH = "user://scene.save"
const tutorial_1_scene = "res://scenes/Levels/Tutorial1/Tutorial1_outdoor_hut_exit.tscn"
var tobik_hut_door_in = false
var repeat_house = false
var repeat_house_in = false

func _ready() -> void:
	var current_scene_path = get_tree().current_scene.scene_file_path
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(current_scene_path)
	file.close()
	print(current_scene_path)

func _input(event):
	print("[DEBUG/MAIN] Pressed "+str(event)+" button")
	if Input.is_action_just_pressed("esc"):
		print("[INFO/MAIN] Starting scene" + MainMenu_scene)
		get_tree().change_scene_to_file(MainMenu_scene)

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	print(str(body))
	repeat_house = false


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	print(str(body))
	repeat_house = true

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and repeat_house:
		get_tree().change_scene_to_file(tutorial1_house_scene)
	if Input.is_action_just_pressed("interact") and repeat_house_in:
		get_tree().change_scene_to_file(tutorial1_out_scene)
	if Input.is_action_just_pressed("interact") and tobik_hut_door_in:
		get_tree().change_scene_to_file(tutorial_1_scene)

func _on_door_house_area_body_entered(body: Node2D) -> void:
	print(str(body))
	repeat_house_in = true


func _on_door_house_area_body_exited(body: Node2D) -> void:
	print(str(body))
	repeat_house_in = false

func _on_tobik_hut_door_body_entered(body: Node2D) -> void:
	print(str(body))
	tobik_hut_door_in = true


func _on_tobik_hut_door_body_exited(body: Node2D) -> void:
	print(str(body))
	tobik_hut_door_in = false


func _on_killzone_outdoor_to_town_body_entered(body: Node2D) -> void:
	print(str(body))
	get_tree().call_deferred("change_scene_to_file", tutorial1_town_scene)

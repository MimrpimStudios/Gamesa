extends Node2D

const tutorial_1_scene = "res://scenes/Levels/Tutorial1/Tutorial1_outdoor_hut_exit.tscn"
var tobik_hut_door_in = false
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and tobik_hut_door_in:
		get_tree().change_scene_to_file(tutorial_1_scene)

func _on_tobik_hut_door_body_entered(body: Node2D) -> void:
	print(str(body))
	tobik_hut_door_in = true


func _on_tobik_hut_door_body_exited(body: Node2D) -> void:
	print(str(body))
	tobik_hut_door_in = false

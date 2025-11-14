extends Area2D

@onready var tobik_hut_button: Button = $"../TobikHutButton"
const tutorial_hut_scene = "res://scenes/Levels/Tutorial1/tobik_hut_in.tscn"
var tobik_hut_door_secret = false

func _on_body_exited(body: Node2D) -> void:
	print(str(body))
	tobik_hut_button.hide()
	tobik_hut_door_secret = false

func _on_body_entered(body: Node2D) -> void:
	print(str(body))
	tobik_hut_button.show()
	tobik_hut_door_secret = true

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and tobik_hut_door_secret:
		get_tree().change_scene_to_file(tutorial_hut_scene)

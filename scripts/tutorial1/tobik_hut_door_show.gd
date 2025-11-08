extends Area2D

@onready var tobik_hut_button: Button = $"../TobikHutButton"
const tutorial_hut_scene = "res://scenes/Levels/Tutorial1/tobik_hut1.tscn"
var repeat = false

func _on_body_exited(body: Node2D) -> void:
	print(str(body))
	tobik_hut_button.hide()
	repeat = false

func _on_body_entered(body: Node2D) -> void:
	print(str(body))
	tobik_hut_button.show()
	repeat = true

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and repeat:
		get_tree().change_scene_to_file(tutorial_hut_scene)

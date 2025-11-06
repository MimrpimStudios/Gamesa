extends Area2D

@onready var tobik_hut_button: Button = $"../TobikHutButton"
const tutorial_hut_scene = "res://scenes/Levels/Tutorial1/tobik_hut1.tscn"

func _on_body_exited(body: Node2D) -> void:
	tobik_hut_button.hide()

func _on_body_entered(body: Node2D) -> void:
	tobik_hut_button.show()

func _on_tobik_hut_button_pressed() -> void:
	get_tree().change_scene_to_file(tutorial_hut_scene)

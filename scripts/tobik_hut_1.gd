extends Node2D

const tutorial_1_scene = "res://scenes/Levels/Tutorial1-hut-exit.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tobik_hut_button_pressed() -> void:
	get_tree().change_scene_to_file(tutorial_1_scene)

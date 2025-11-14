extends Area2D

const tutorial1_town_scene = "res://scenes/Levels/Tutorial1/Tutorial1_town.tscn"

func _on_body_entered(body: Node2D) -> void:
	print(str(body))
	get_tree().call_deferred("change_scene_to_file", tutorial1_town_scene)

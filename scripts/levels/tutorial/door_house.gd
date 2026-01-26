extends Area2D

var repeat = false

func _on_body_exited(_body: Node2D) -> void:
	repeat = false


func _on_body_entered(_body: Node2D) -> void:
	repeat = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("integrate") and repeat:
		get_tree().change_scene_to_file(global_var.house_01_scene_in)

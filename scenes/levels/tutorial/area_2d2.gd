extends Area2D

var repeat5 = false

func _on_body_exited(_body: Node2D) -> void:
	repeat5 = false


func _on_body_entered(_body: Node2D) -> void:
	repeat5 = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("integrate") and repeat5:
		get_tree().change_scene_to_file(global_var.pharmacy_in_02_scene)

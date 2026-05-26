extends Area2D

var repeat6 = false

func _on_body_exited(_body: Node2D) -> void:
	repeat6 = false


func _on_body_entered(_body: Node2D) -> void:
	repeat6 = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("integrate") and repeat6:
		get_tree().change_scene_to_file(global_var.out_02_scene)

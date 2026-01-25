extends Area2D

var repeat3 = false

func _on_body_exited(_body: Node2D) -> void:
	repeat3 = false


func _on_body_entered(_body: Node2D) -> void:
	repeat3 = true

func _process(_delta: float) -> void:
	print(str(repeat3))
	if Input.is_action_just_pressed("integrate") and repeat3:
		get_tree().change_scene_to_file(global_var.out_01_scene)

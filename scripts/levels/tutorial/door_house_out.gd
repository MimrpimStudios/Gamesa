extends Area2D

var body = false
func _on_body_entered(_body: Node2D) -> void:
	body = true


func _on_body_exited(_body: Node2D) -> void:
	body = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("integrate") and body:
		get_tree().change_scene_to_file(global_var.out_01)

extends Area2D

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var repeat = false


func _on_body_exited(_body: Node2D) -> void:
	repeat = false


func _on_body_entered(_body: Node2D) -> void:
	repeat = true


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("integrate") and repeat:
		animation_player.play("fade")
		await animation_player.animation_finished
		get_tree().change_scene_to_file(global_var.house_03_story_scene)

extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_var.player_movement = false




func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "proslov":
		global_var.player_movement = true

extends AnimatableBody2D

@onready var collision: CollisionShape2D = $SmashJump/CollisionShape2D


func _physics_process(_delta: float) -> void:
	if global_var.is_player_smashing:
		collision.disabled = false
	else:
		collision.disabled = true

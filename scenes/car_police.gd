extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction = 0


func _physics_process(_delta: float) -> void:
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()

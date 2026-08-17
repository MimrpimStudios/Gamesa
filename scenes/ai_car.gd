extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if ray_cast_2d.is_colliding() or not ray_cast_2d_2.is_colliding():
		direction *= -1
		
		ray_cast_2d.target_position.x *= -1
		
		ray_cast_2d_2.position.x *= -1

	animated_sprite_2d.flip_h = (direction == -1)
	velocity.x = direction * SPEED

	move_and_slide()

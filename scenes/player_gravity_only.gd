extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var npc: CharacterBody2D = $"."

@export_range(0, 100, 0.1, "or_greater", "or_less") var SPEED: float = 150.0
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export_range(0, 1000, 1.0, "or_greater", "or_less") var JUMP_VELOCITY_kladna = 450.0
var JUMP_VELOCITY = JUMP_VELOCITY_kladna * -1
var direction: int = 0

func _process(_delta: float) -> void:
	if global_var.is_player_dead:
		if is_instance_valid(collision_shape_2d):
			collision_shape_2d.queue_free()
		global_var.player_health = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction == 0:
		animated_sprite.play("stand")
	if direction < 0:
		animated_sprite.play("right")
	elif direction > 0:
		animated_sprite.play("left")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("stand")
	move_and_slide()

func jump():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func jump_off():
	if velocity.y < -100:
		velocity.y = -100

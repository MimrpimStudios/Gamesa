extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var npc: CharacterBody2D = $"."

@export_range(0, 100, 0.1, "or_greater", "or_less") var SPEED: float = 150.0
@export_range(0, 1000, 1.0, "or_greater", "or_less") var JUMP_VELOCITY_kladna = 450.0
var JUMP_VELOCITY = JUMP_VELOCITY_kladna * -1
var direction = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if direction == 0:
		animated_sprite.play("default")
	if direction < 0:
		animated_sprite.play("left")
	elif direction > 0:
		animated_sprite.play("right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("default")
	move_and_slide()


func _on_walking_01():
	direction = 1
	await get_tree().create_timer(1.2).timeout
	direction = 0
	await get_tree().create_timer(0.5).timeout
	npc.hide()
	await get_tree().create_timer(5.0).timeout
	npc.show()
	await get_tree().create_timer(0.5).timeout
	direction = -1
	await get_tree().create_timer(1.2).timeout
	direction = 0

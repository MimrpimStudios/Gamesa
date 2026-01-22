extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export_range(0, 100, 0.1, "or_greater", "or_less") var SPEED: float = 80.0
@export_range(0, 1000, 1.0, "or_greater", "or_less") var JUMP_VELOCITY_kladna = 450.0
var JUMP_VELOCITY = JUMP_VELOCITY_kladna * -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _process(_delta: float) -> void:
	if global_var.is_player_dead:
		if is_instance_valid(collision_shape_2d):
			collision_shape_2d.queue_free()
		global_var.player_health = 0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if global_var.player_movement == true:
		# Add the gravity.
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			if Input.is_action_pressed("sprint"):
				SPEED = 150.0
				JUMP_VELOCITY = -450.0
			velocity.y = JUMP_VELOCITY
			
		if Input.is_action_just_released("jump"):
			if velocity.y < -100:
				velocity.y = -100

		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			if Input.is_action_pressed("sprint"):
				SPEED = 150.0
		else:
			SPEED = 80.0
		# Get the input direction: -1, 0, 1
		var direction = Input.get_axis("left", "right")
		

		
		# Play animations
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("stand")
		if direction > 0:
			animated_sprite.play("left")
		elif direction < 0:
			animated_sprite.play("right")
			
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite.play("stand")
		move_and_slide()
	else:
		animated_sprite.play("stand")

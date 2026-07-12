extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var dialog_player: Label = $DialogPlayer

@export_range(0, 100, 0.1, "or_greater", "or_less") var SPEED: float = 150.0
@export_range(0, 1000, 1.0, "or_greater", "or_less") var JUMP_VELOCITY_kladna = 450.0
var JUMP_VELOCITY = JUMP_VELOCITY_kladna * -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var default_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation = animated_sprite.animation


func _process(_delta: float) -> void:
	if global_var.is_player_dead:
		if is_instance_valid(collision_shape_2d):
			collision_shape_2d.queue_free()
		global_var.player_health = 0


func _physics_process(delta):
	if not is_on_floor() and global_var.is_player_dead == false:
		velocity.y += gravity * delta
		if global_var.player_movement == false:
			move_and_slide()
	if global_var.player_movement == true:
		# Add the gravity.
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		if Input.is_action_just_released("jump"):
			if velocity.y < -100:
				velocity.y = -100

		# handle smash
		if not is_on_floor():
			global_var.is_player_smashing = true
		else:
			global_var.is_player_smashing = false
		# Get the input direction: -1, 0, 1
		var direction = Input.get_axis("left", "right")

		# Play animations
		if is_on_floor():
			if direction == 0:
				if animation != "sitting":
					animated_sprite.play("stand")
		if direction > 0:
			animated_sprite.play("left")
		elif direction < 0:
			animated_sprite.play("right")

		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if animation != "sitting":
				animated_sprite.play("stand")
		move_and_slide()
	else:
		if animation != "sitting":
			animated_sprite.play("stand")
		velocity.x = 0
		if not global_var.is_player_dead:
			move_and_slide()


func say(text: String):
	dialog_player.text = text
	print(text)

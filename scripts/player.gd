extends CharacterBody2D
@onready var die_label = $Camera2D2/die_label
@onready var collision_shape = $CollisionShape2D
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0


func die():
	print("[DEBUG/PLAYER] showing die_label and die_blur")
	die_label.show()
	set_process(false)
	set_physics_process(false)
	if is_instance_valid(collision_shape):
		collision_shape.set_deferred("disabled", true)
		
func _ready():
	print("[DEBUG/PLAYER] hiding die_label and die_blur")
	die_label.hide()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jumps
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y *= 0.5
	
	# Flip the Sprite
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

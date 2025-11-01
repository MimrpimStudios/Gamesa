extends CharacterBody2D
@onready var die_label = $die_label
# Oprava: find_child může být pomalé a nespolehlivé. Zkusíme to přes Group.
# Ale pro teď, necháme find_child a zkontrolujeme jej.
@onready var world_environment = get_tree().root.find_child("WorldEnvironment", true) 
@onready var collision_shape = $CollisionShape2D
@onready var animated_sprite = $AnimatedSprite2D
const SPEED = 200.0
const JUMP_VELOCITY = -400.0


func die():
	die_label.show()
	set_process(false)
	set_physics_process(false)
	if is_instance_valid(collision_shape):
		collision_shape.set_deferred("disabled", true)
		
func _ready():
	die_label.hide()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jumps
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= 0.5
	
	# Flip the Sprite
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

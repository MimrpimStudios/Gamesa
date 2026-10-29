extends CharacterBody2D

@onready var point_light_2d: PointLight2D = $PointLight2D
const FLASHLIGHT = preload("uid://b23qkbh4hiopk")
const FLASHLIGHT_2 = preload("uid://jqtcicqflvpp")

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var direction: int
@export var valid_gravity: bool = true
func _physics_process(delta: float) -> void:
	if valid_gravity:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction == 1:
		point_light_2d.texture = FLASHLIGHT
		point_light_2d.offset.x = -18
	else:
		point_light_2d.texture = FLASHLIGHT_2
		point_light_2d.offset.x = 18

	move_and_slide()

func jump() -> void:
	# Handle jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

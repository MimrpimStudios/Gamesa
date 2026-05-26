extends CharacterBody2D

@onready var dialog: Label = $Dialog
@onready var timer: Timer = $Timer

@export_range(0, 100, 0.1, "or_greater", "or_less") var SPEED: float = 150.0
@export_range(0, 1000, 1.0, "or_greater", "or_less") var JUMP_VELOCITY_kladna = 450.0
var JUMP_VELOCITY = JUMP_VELOCITY_kladna * -1
var first = true

func _ready() -> void:
	dialog.text = ""

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.

	move_and_slide()

func dialog_01():
	if first:
		timer.stop()
		dialog.text = "Hello, I am NPC"
		timer.start(1)
		first = false
	else:
		timer.stop()
		dialog.text = "I already said, I am NPC"
		timer.start(1)



func _on_timer_timeout() -> void:
	dialog.text = ""

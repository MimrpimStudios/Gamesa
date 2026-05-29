extends CharacterBody2D

@onready var dialog: Label = $Dialog
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $"../Player"

@export_range(0, 100, 0.1, "or_greater", "or_less") var SPEED: float = 150.0
@export_range(0, 1000, 1.0, "or_greater", "or_less") var JUMP_VELOCITY_kladna = 450.0
var JUMP_VELOCITY = JUMP_VELOCITY_kladna * -1
var first = true
var running_dialog = false
signal integrade_pressed
func _ready() -> void:
	dialog.text = ""

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("integrate"):
		integrade_pressed.emit()
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.

	move_and_slide()
func dialog_01(number: int):
	# Pokud timer už běží (> 0), znamená to, že dialog právě probíhá.
	# Chceme ho ignorovat, aby se nespustil znovu od začátku.
	if timer.time_left > 0:
		return

	if number == 1 and not running_dialog:
		if first:
			dialog.text = "Hello, I am NPC"
			first = false
			running_dialog = true
			global_var.player_movement = false
			global_var.player_show_speakNPC = false
			
			timer.start(5)
			await timer.timeout # Čeká na konec 2s nebo na stisk tlačítka
			
			dialog.text = "How are you?"
			player.say("Good!")
			running_dialog = false
			timer.start(5)
			await timer.timeout # Čeká na konec 5s nebo na stisk tlačítka
			
			
			dialog.text = "" # Text zmizí až po úplném skončení dialogu
			player.say("")
			global_var.player_show_speakNPC = true
			global_var.player_movement = true
		else:
			running_dialog = true
			dialog.text = "I already said, I am NPC"
			global_var.player_show_speakNPC = false
			global_var.player_movement = false
			timer.start(5)
			await timer.timeout # Čeká 5s nebo na stisk tlačítka
			running_dialog = false
			
			dialog.text = "" # Text zmizí
			global_var.player_show_speakNPC = true
			global_var.player_movement = true


func _on_integrade_pressed() -> void:
	# Tlačítko má smysl mačkat jen v případě, že se na obrazovce něco děje (timer běží)
	if timer.time_left > 0:
		timer.stop()
		timer.timeout.emit()

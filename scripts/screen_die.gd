extends  Control

@onready var die: Control = $"."
@onready var label_count: Label = $LabelCount
@onready var timer_killzone: Timer = $"../../Killzone/Timer"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	die.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if global_var.is_player_dead:
		die.show()
		label_count.text = "You will be respawned in " + str(int(float(timer_killzone.time_left)) + 1) + " seconds..."
	else:
		die.hide()

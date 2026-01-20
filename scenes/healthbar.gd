extends Control

@onready var fill: ColorRect = $Fill

var player_heart_procent = int((global_var.player_health * 100.0) / global_var.player_max_health)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	player_heart_procent = int((global_var.player_health * 100.0) / global_var.player_max_health)
	fill.size.x = player_heart_procent

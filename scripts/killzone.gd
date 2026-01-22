extends Area2D

@onready var timer = $Timer
@export var damage: int = 999
func _on_body_entered(body):
	if body.name == "Player":
		global_var.player_health = global_var.player_health - damage
		print("Giving to the " + str(body) + " damage: " + str(damage))
	else:
		print("Killing body: " + str(body) + " with Node name: " + body.name)
		body.get_node("CollisionShape2D").queue_free()

func _process(_delta: float) -> void:
	if global_var.is_player_dead and timer.is_stopped():
		timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
	global_var.player_health = global_var.player_max_health

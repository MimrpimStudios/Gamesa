extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	if body.name == "Player":
		body.get_node("CollisionShape2D").queue_free()
		global_var.player_health = 0
		timer.start()
		global_var.player_movement = false
	print("Killing body: " + str(body) + " with Node name: " + body.name)
	body.get_node("CollisionShape2D").queue_free()

func _on_timer_timeout():
	get_tree().reload_current_scene()
	global_var.player_health = global_var.player_max_health

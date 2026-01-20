extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	global_var.player_health = 0


func _on_timer_timeout():
	Engine.time_scale = 1.0
	global_var.player_health = 3
	get_tree().reload_current_scene()

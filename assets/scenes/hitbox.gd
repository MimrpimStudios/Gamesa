# killzone.gd
extends Area2D
@onready var timer = $Timer
func _on_body_entered(body):
	
	if body.is_in_group("enemy"):
		
		print("player died - bullet time aktivován a spouštím odpočet")
		
		# 1. Spuštění efektů (die()) ODLOŽÍME
		# Použijeme volání 'call_deferred' pro funkci 'die' na tělese 'body'
		body.call_deferred("die")
		timer.wait_time = 0.2
		timer.start() 
		

func _on_timer_timeout():
	# Tady necháme původní kód
	Engine.time_scale = 1.0 
	get_tree().reload_current_scene()

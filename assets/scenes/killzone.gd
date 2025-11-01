# killzone.gd
extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	
	if body.is_in_group("player"):
		
		print("player died - bullet time aktivován a spouštím odpočet")
		
		# 1. Spuštění efektů (die()) ODLOŽÍME
		# Použijeme volání 'call_deferred' pro funkci 'die' na tělese 'body'
		body.call_deferred("die") 
		
		# 2. Zpomalení času (může zůstat zde, protože neovlivňuje signál)
		Engine.time_scale = 0.5 
		
		# 3. Odloží vypnutí monitorování
		set_deferred("monitoring", false) 
		
		# 4. Spustí Timer
		if is_instance_valid(timer):
			timer.wait_time = 0.2
			timer.start() 
		
	else:
		# Zničí cokoliv, co není hráč
		print("Neznámý objekt/nepřítel zničen: " + body.name)
		body.queue_free()

func _on_timer_timeout():
	# Tady necháme původní kód
	Engine.time_scale = 1.0 
	get_tree().reload_current_scene()

# killzone.gd
extends Area2D

@onready var timer = $Timer
var count = int(0)
const tutorial_scene = "res://scenes/Levels/Tutorial1.tscn"

func _on_body_entered(body):
	print("[DEBUG/KILLZONE] entered " + str(body))
	if body.is_in_group("player"):
		print("[DEBUG/KILLZONE] Recognized player")
		print("[DEBUG/KILLZONE] calling " + str(body) + " dye")
		body.call_deferred("die")
		print("[INFO/KILLZONE] Setting Engine.time_scale to 0.5")
		Engine.time_scale = 0.5
		print("[INFO/KILLZONE] Setting deferred monitoring to false")
		set_deferred("monitoring", false) 
		print("[INFO/KILLZONE] setting timer.wait_time to 0.25")
		timer.wait_time = 0.25
		print("[INFO/KILLZONE] Starting timer")
		timer.start() 
	else:
		body.queue_free()

func _on_timer_timeout():
	print("[INFO/KILLZONE] Setting Engine.time_scale to 1")
	Engine.time_scale = 1.0
	print("[INFO/KILLZONE] Reloading current scene")
	get_tree().change_scene_to_file(tutorial_scene)

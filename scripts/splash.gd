extends Control
@onready var timer = $Timer
@onready var animationplayer = $AnimationPlayer
const MainMenu_scene = "res://scenes/MainMenu.tscn"
func _ready():
	set_process_input(true)
	print("[INFO/SPLASH] Starting splash video")
	animationplayer.play("fade_out")
	
	

func _on_timer_timeout():
	get_tree().change_scene_to_file(MainMenu_scene)
	print("[INFO/SPLASH] Splash ended. Starting " + MainMenu_scene)
func _input(ev):
	if Input.is_anything_pressed() == true:
		print("[INFO/SPLASH] Registrated input: " + str(ev) + " so splash ended, stopping timer and Starting " + MainMenu_scene)
		timer.stop()
		get_tree().change_scene_to_file(MainMenu_scene)

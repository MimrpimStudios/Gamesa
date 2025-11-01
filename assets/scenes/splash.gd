extends Control
@onready var timer = $Timer
@onready var animationplayer = $AnimationPlayer

func _ready():
	set_process_input(true)
	animationplayer.play("fade_out")
	
	

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://assets/scenes/main.tscn")

func _input(ev):
	if Input.is_anything_pressed() == true:
			timer.stop()
			get_tree().change_scene_to_file("res://assets/scenes/main.tscn")

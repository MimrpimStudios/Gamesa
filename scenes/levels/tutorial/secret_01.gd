extends Area2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $AudioStreamPlayer/Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	timer.wait_time = 0.5
	timer.start()
	global_var.player_movement = false
	$"../Player".set_position(Vector2(1321, 119))

func _on_timer_timeout() -> void:
	if timer.wait_time == 0.5:
		timer.wait_time = 4.20
		timer.start()
		audio_stream_player.play()
		$"../TileMapLayer/TileMapLayer2".hide()
		get_tree().change_scene_to_file(global_var.secret_01_scene)
	else:
		audio_stream_player.stop()

extends Area2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $AudioStreamPlayer/Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ufo: AnimatedSprite2D = $"../ufo/ufo"

var count = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("RESET")
	ufo.play("default")

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
		timer.wait_time = 8
		timer.start()
		audio_stream_player.play()
		$"../TileMapLayer/TileMapLayer2".hide()
		animation_player.play("secret_01")
	else:
		audio_stream_player.stop()
		get_tree().change_scene_to_file(global_var.secret_01_scene)




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "secret_01":
		ufo.play("beam")

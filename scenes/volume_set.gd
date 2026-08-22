extends Control

@onready var button_stop: Button = $ButtonStop
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var button_play: Button = $ButtonPlay
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player2: AnimationPlayer = $ButtonPlay/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.show()
	button_play.hide()
	await get_tree().create_timer(0.8).timeout
	animation_player.play("fade_in")
	await get_tree().create_timer(0.05).timeout
	color_rect.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	button_stop.visible = audio_stream_player.playing

func _on_button_pressed() -> void:
	audio_stream_player.play()
	if not button_play.visible:
		await get_tree().create_timer(1).timeout
		button_play.show()
		animation_player2.play("fade_in")



func _on_button_stop_button_down() -> void:
	audio_stream_player.stop()


func _on_button_play_pressed() -> void:
	animation_player.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		await get_tree().create_timer(0.8).timeout
		get_tree().change_scene_to_file(global_var.intro_scene)

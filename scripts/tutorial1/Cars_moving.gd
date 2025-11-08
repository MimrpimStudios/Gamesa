extends AnimationPlayer

@onready var animation_player: AnimationPlayer = $"."
@onready var animation_player_2: AnimationPlayer = $"../AnimationPlayer2"
@onready var animation_player_3: AnimationPlayer = $"../AnimationPlayer3"

func _ready() -> void:
	animation_player.play("car_moving")

func _on_timer_timeout() -> void:
	animation_player_2.play("car_moving_2")
	

func _on_timer_2_timeout() -> void:
	animation_player_3.play("car_moving_3")

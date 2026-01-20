extends Area2D

@onready var timer: Timer = $Timer
var animation = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if animation:
		animation = false
		var camera2d = body.get_node_or_null("Camera2D")
		if camera2d:
			var tween = get_tree().create_tween()
			global_var.player_movement = false
			timer.start()
			tween.tween_property(camera2d, "zoom", Vector2(5.0, 5.0), 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
			


func _on_timer_timeout() -> void:
	global_var.player_movement = true

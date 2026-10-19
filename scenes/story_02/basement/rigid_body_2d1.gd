extends RigidBody2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze=true





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		freeze = false

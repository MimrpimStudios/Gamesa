extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../CameraZoomIn/CollisionShape2D2".set_deferred("disabled", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(_body: Node2D) -> void:
	$"../CameraZoomIn/CollisionShape2D2".set_deferred("disabled", false)
	$"../CameraZoomIn".animation = true

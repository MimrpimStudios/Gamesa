extends AnimationPlayer

@onready var ap: AnimationPlayer = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ap.play("change_cam")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

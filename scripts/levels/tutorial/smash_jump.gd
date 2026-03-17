extends Area2D

@onready var as_body: AnimatedSprite2D = $AnimatedSprite2DBody


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	as_body.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if global_var.is_player_smashing:
		global_var.is_player_smashing_disabled = true
		body.velocity.y  = body.JUMP_VELOCITY
		for n in get_children():
			n.queue_free()
		await get_tree().create_timer(0.5).timeout
		global_var.is_player_smashing_disabled = false

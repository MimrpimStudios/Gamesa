extends Area2D

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	global_var.player_movement = false
	animation_player.play("reset_cam")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "reset_cam":
		get_tree().change_scene_to_file(global_var.town_02_scene)

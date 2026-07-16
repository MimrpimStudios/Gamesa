extends Area2D

@onready var player: CharacterBody2D = %Player
@onready var animated_sprite_2d: AnimatedSprite2D = $"../Player/AnimatedSprite2D"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var repeat: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if repeat and Input.is_action_just_pressed("integrate") or not global_var.player_movement:
		global_var.player_movement = false
		player.global_position = Vector2(459.0, 357.0)
		animated_sprite_2d.animation = "sitting_couch"
		credits_run()


func _on_body_entered(_body: Node2D) -> void:
	repeat = true


func _on_body_exited(_body: Node2D) -> void:
	repeat = false

func credits_run():
	await get_tree().create_timer(1).timeout
	animation_player.play("fade")
	await animation_player.animation_finished
	global_var.credits_true = true
	if not is_inside_tree():
		return
	get_tree().change_scene_to_file(global_var.credits_scene)

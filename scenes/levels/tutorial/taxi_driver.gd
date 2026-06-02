extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var car_taxi: CharacterBody2D = $".."
@onready var player: CharacterBody2D = %Player
@onready var root: Node2D = $"../.."
@onready var camera_2d: Camera2D = $"../../Player/Camera2D"
var repeat: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_var.player_show_speakNPC_color = Color(1.0, 1.0, 1.0, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_var.player_show_speakNPC = repeat
	if repeat and Input.is_action_just_pressed("integrate"):
		collision_shape_2d.queue_free()
		repeat = false
		global_var.player_movement = false
		animation.play("taxi_speak")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		repeat = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		repeat = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "taxi_speak":
		camera_2d.enabled = false
		player.reparent(car_taxi)
		camera_2d.enabled = true
		taxi_go()
	if anim_name == "taxi_post":
		global_var.player_movement = true
func taxi_go():
	car_taxi.direction = -1
	await get_tree().create_timer(13.5).timeout
	car_taxi.direction = 0
	await get_tree().create_timer(3).timeout
	camera_2d.enabled = false
	player.reparent(root)
	camera_2d.enabled = true
	player.z_index = 1000
	await get_tree().create_timer(1).timeout
	animation.play("taxi_post")

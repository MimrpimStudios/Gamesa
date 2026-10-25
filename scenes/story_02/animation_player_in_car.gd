extends AnimationPlayer

@onready var car: CharacterBody2D = $"../Car"
@onready var player: CharacterBody2D = %Player
@onready var animated_sprite_2d: AnimatedSprite2D = $"../Car/AnimatedSprite2D"
@onready var camera_2d: Camera2D = $"../Car/Player/Camera2D"

@onready var player_collision_shape_2d: CollisionShape2D = $"../Car/Player/CollisionShape2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().physics_frame
	global_var.player_movement = false
	global_var.player_gravity = false
	player_collision_shape_2d.disabled = true
	player.position.y =- 4
	player.hide()

#func _process(_delta: float) -> void:
#	if animated_sprite_2d.frame == 0:
#		camera_2d.position = Vector2(0.0, 0.0)
#	else:
#		camera_2d.position = Vector2(0.0, -1.0)


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "intro":
		play("car_anim")
	if anim_name == "car_anim":
		player_collision_shape_2d.disabled = false
		global_var.player_gravity = true
	if anim_name == "camera_out":
		global_var.player_movement = true

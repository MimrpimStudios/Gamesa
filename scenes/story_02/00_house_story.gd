extends Node2D

@onready var thief_animated_sprite_2d: AnimatedSprite2D = $Thief/AnimatedSprite2D
@onready var thief: CharacterBody2D = $Thief
@onready var thief_2: CharacterBody2D = $Thief2
@onready var thief_2_animated_sprite_2d: AnimatedSprite2D = $Thief2/AnimatedSprite2D
@onready var player: CharacterBody2D = $Player
@onready var collision_shape_2d: CollisionShape2D = $Player/CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	global_var.player_movement = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	global_var.level = get_tree().current_scene.scene_file_path
	global_var.save_level_story_2()
	thief_animated_sprite_2d.speed_scale = 1.5
	thief_animated_sprite_2d.animation = "left"
	thief.hide()
	thief_2_animated_sprite_2d.speed_scale = 1.5
	thief_2_animated_sprite_2d.animation = "left"
	thief_2.hide()
	await get_tree().create_timer(5).timeout
	thief.show()
	thief.direction = -1
	await get_tree().create_timer(0.3).timeout
	thief_2.show()
	thief_2.direction = -1
	await get_tree().create_timer(0.15).timeout
	thief.jump()
	await get_tree().create_timer(0.4).timeout
	thief_2.jump()
	await get_tree().create_timer(0.1).timeout
	thief.direction = 0
	
	thief_animated_sprite_2d.speed_scale = 1
	thief_animated_sprite_2d.animation = "default"
	await get_tree().create_timer(0.2).timeout
	thief_2.direction = 0

	thief_2_animated_sprite_2d.speed_scale = 1
	thief_2_animated_sprite_2d.animation = "default"
	
	await get_tree().create_timer(0.05).timeout
	player.reparent(thief_2)
	thief_2.reparent(thief)
	collision_shape_2d.queue_free()
	player.position = Vector2(0, player.position.y - 7)
	await get_tree().create_timer(0.3).timeout
	thief_animated_sprite_2d.speed_scale = 1.5
	thief_animated_sprite_2d.animation = "right"
	thief_2_animated_sprite_2d.speed_scale = 1.5
	thief_2_animated_sprite_2d.animation = "right"
	thief.direction = 1
	await get_tree().create_timer(0.9).timeout
	thief_2.hide()
	await get_tree().create_timer(0.1).timeout
	thief.hide()
	await get_tree().create_timer(1).timeout
	animation_player.play("fade")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

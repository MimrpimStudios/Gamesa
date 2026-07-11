extends Node2D

@onready var mimrpim_studios: Sprite2D = $Player/MimrpimStudios
@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = %Camera2D
@onready var label: Label = $Player/Label
@onready var collision_shape_2d: CollisionShape2D = $Player/CollisionShape2D

var camera = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mimrpim_studios.hide()
	label.hide()
	if global_var.intro_play:
		await get_tree().create_timer(3).timeout
		mimrpim_studios.show()
		await get_tree().create_timer(3).timeout
		mimrpim_studios.hide()
		await get_tree().create_timer(1.5).timeout
		
		player.direction = 1
		await get_tree().create_timer(2.8).timeout
		player.jump()
		await get_tree().create_timer(0.3).timeout
		player.jump_off()
		await get_tree().create_timer(0.12).timeout
		player.direction = 0
		await get_tree().create_timer(1.5).timeout
		label.show()
		await get_tree().create_timer(1.5).timeout
		label.hide()
		await get_tree().create_timer(3).timeout
		
		player.direction = 1
		player.jump()
		await get_tree().create_timer(0.3).timeout
		player.jump_off()
		await get_tree().create_timer(2.8).timeout
		player.jump()
		await get_tree().create_timer(0.3).timeout
		player.jump_off()
		await get_tree().create_timer(0.12).timeout
		player.direction = 0
		await get_tree().create_timer(1.5).timeout
		label.set_text("By Mimrpim")
		label.show()
		await get_tree().create_timer(3).timeout
		label.hide()
		await get_tree().create_timer(1.5).timeout
		collision_shape_2d.queue_free()
		camera = false
		await get_tree().create_timer(1.5).timeout
		global_var.player_health = 0
		global_var.intro_play = false
	else:
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file(global_var.main_scene)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if camera:
		camera_2d.global_position = player.global_position

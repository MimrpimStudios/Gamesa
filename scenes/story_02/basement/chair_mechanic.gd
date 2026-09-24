extends Node

@onready var player: CharacterBody2D = $"../Player"

var jump_count: int = 0
func _ready() -> void:
	await get_tree().process_frame
	global_var.player_movement = false

func _physics_process(_delta: float) -> void:
	if not global_var.player_movement:
		player.position = Vector2(8.0, -3.0)

func _input(_event: InputEvent) -> void:
	if not jump_count == 5:
		if Input.is_action_just_pressed("jump"):
			jump_count += 1
	else:
		await get_tree().process_frame
		global_var.player_movement = true

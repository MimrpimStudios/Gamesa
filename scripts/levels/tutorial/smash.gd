extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var rat: CharacterBody2D = $".."
@onready var player: CharacterBody2D = $"../../Player"
@onready var collision_shape_2d_killzone: CollisionShape2D = $"../Killzone2/CollisionShape2D"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_shape_2d.disabled = false
	collision_shape_2d_killzone.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if global_var.is_player_smashing and not player.is_on_floor():
		collision_shape_2d.disabled = false
		collision_shape_2d_killzone.disabled = true
	else:
		collision_shape_2d.disabled = true
		collision_shape_2d_killzone.disabled = false


func _on_body_entered(_body: Node2D) -> void:
	rat.queue_free()

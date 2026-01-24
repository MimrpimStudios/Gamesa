extends Node

var player_movement = true
var is_player_dead = false
var player_health = 3
var player_max_health = 3
const house_01_scene = "res://scenes/levels/tutorial/01_house.tscn"
const house_01_scene_in = "res://scenes/levels/tutorial/01_house_in.tscn"
const out_01_scene = "res://scenes/levels/tutorial/01_out.tscn"
const secret_01_scene = "res://scenes/levels/tutorial/01_secret.tscn"
var hide_overaly = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_health <= 0:
		is_player_dead = true
	else:
		is_player_dead = false

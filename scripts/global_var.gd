extends Node

var player_movement = true
var is_player_dead = false
var player_health = 3
var player_max_health = 3
var hide_overaly = false
const town_01_scene = "res://scenes/levels/tutorial/01_town.tscn"
const house_01_scene = "res://scenes/levels/tutorial/01_house.tscn"
const house_01_scene_in = "res://scenes/levels/tutorial/01_house_in.tscn"
const out_01_scene = "res://scenes/levels/tutorial/01_out.tscn"
const secret_01_scene = "res://scenes/levels/tutorial/01_secret.tscn"
const main_menu_scene = "res://scenes/main_menu.tscn"
const start_scene_story = house_01_scene
const start_scene = main_menu_scene
const version = "1.0-t2.5"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_health <= 0:
		is_player_dead = true
	else:
		is_player_dead = false

extends Node

var intro_play = true
var credits_true = false
var player_show_speakNPC = false
var player_show_speakNPC_color: Color = Color(0.0, 0.0, 0.0, 1.0)
var player_movement = true
var is_player_dead = false
var is_player_smashing = false
var is_player_smashing_disabled = false
var healthbar_show = false
var player_health = 3
var player_max_health = 3
var hide_overaly = false
const volume_set_scene = "res://scenes/volume_set.tscn"
const house_00_story_scene = "res://scenes/levels/tutorial/00_house_story.tscn"
const house_03_story_scene = "res://scenes/levels/tutorial/03_house_story.tscn"
const main_scene = "res://scenes/main.tscn"
const town_01_scene = "res://scenes/levels/tutorial/01_town.tscn"
const house_01_scene = "res://scenes/levels/tutorial/01_house.tscn"
const house_01_in_scene = "res://scenes/levels/tutorial/01_house_in.tscn"
const out_01_scene = "res://scenes/levels/tutorial/01_out.tscn"
const secret_01_scene = "res://scenes/levels/tutorial/01_secret.tscn"
const main_menu_scene = "res://scenes/main_menu.tscn"
const fall_scene = "res://scenes/levels/tutorial/01_fall.tscn"
const boss_01_scene = "res://scenes/levels/tutorial/01_boss1.tscn"
const stoky2_scene = "res://scenes/levels/tutorial/01_stoky_checkpoint2.tscn"
const stoky3_scene = "res://scenes/levels/tutorial/01_stoky_checkpoint3.tscn"
const start_scene_story = house_00_story_scene
const start_scene_new_game = volume_set_scene
const start_scene = main_menu_scene
const version = "1.0-a1.0"
const stoky_scene = "res://scenes/levels/tutorial/01_stoky.tscn"
const stoky_no_monolog_scene = "res://scenes/levels/tutorial/01_stoky_checkpoint_no_monolog.tscn"
const town_02_scene = "res://scenes/levels/tutorial/02_town.tscn"
const pharmacy_in_01_scene = "res://scenes/levels/tutorial/pharmacy_in_01.tscn"
const pharmacy_in_02_scene = "res://scenes/levels/tutorial/pharmacy_in_02.tscn"
const town_02_back_home_scene = "res://scenes/levels/tutorial/town_02_back_home.tscn"
const out_02_scene = "res://scenes/levels/tutorial/02_out.tscn"
const house_02_in_scene = "res://scenes/levels/tutorial/02_house_in.tscn"
const intro_scene = "res://scenes/intro.tscn"
const credits_scene = "res://scenes/credits.tscn"
const cicada_scene = "res://scenes/cidada.tscn"

const menus = [
	"res://scenes/main_menu.tscn",
	"res://scenes/main.tscn",
	"res://scenes/volume_set.tscn",
	"res://scenes/intro.tscn"
	
]

var level
var launcher_type = ""
var launcher_version = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_health <= 0:
		is_player_dead = true
	else:
		is_player_dead = false


func load_level():
	print("Loading...")
	if not FileAccess.file_exists("user://savefile.save"):
		print("Aborting, no savefile")
		return start_scene_new_game
	var save_file = FileAccess.open("user://savefile.save", FileAccess.READ)
	level = save_file.get_line()
	save_file.close()
	print("Loading " + str(level) + "...")
	return level


func save_level():
	print("Saving " + str(level) + "...")
	var save_file = FileAccess.open("user://savefile.save", FileAccess.WRITE)
	save_file.store_line(level)
	save_file.close()

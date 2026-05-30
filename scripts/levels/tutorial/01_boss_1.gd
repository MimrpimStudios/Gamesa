extends Node2D

@onready var rat: CharacterBody2D = $Rat
@onready var rat_2: CharacterBody2D = $Rat2
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var boss_phase = 1
var rat_template: CharacterBody2D
var two_rat: CharacterBody2D
var two_rat_2: CharacterBody2D


func _ready() -> void:
	# DŮLEŽITÉ: duplicate() vytvoří kopii, ale ta není ve scéně (orphan node).
	# To je přesně to, co chceme pro šablonu.
	rat_template = rat.duplicate()

	global_var.player_movement = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	SewersMusic.stop()
	global_var.level = get_tree().current_scene.scene_file_path
	global_var.save_level()


func _process(_delta: float) -> void:
	# FÁZE 1: Čekáme, až zemřou první dvě krysy
	#if boss_phase == 1:
	#	if not is_instance_valid(rat) and not is_instance_valid(rat_2):
	#		print("První fáze hotova, jdeme na druhou!")
	#		boss_phase = 2 # Přepneme na fázi 2
	#
	# FÁZE 2: Spawne nové krysy (proběhne jen jednou díky změně fáze na 3)
	#if boss_phase == 2:
	#	two_rat = rat_template.duplicate()
	#	two_rat.global_position = Vector2(1705.0, 402.0)
	#	add_child(two_rat)
	#	
	#	two_rat_2 = rat_template.duplicate()
	#	two_rat_2.global_position = Vector2(1326.0, 402.0)
	#	add_child(two_rat_2)
	#	
	#	boss_phase = 3 # Okamžitě změníme fázi, aby se znovu nespawnovaly!
	#	print("Dvě nové krysy se objevily!")
	#
	# FÁZE 3: Čekáme na smrt nových krys
	#if boss_phase == 3:
	#	if not is_instance_valid(two_rat) and not is_instance_valid(two_rat_2):
	#		print("Boss poražen!")
	#		boss_phase = 4 # Konec boje
	if not is_instance_valid(rat) and not is_instance_valid(rat_2) and not boss_phase == 4:
		print("Boss poražen!")
		boss_phase = 4 # Konec boje
		animation_player.play("music-off")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("esc"):
		get_tree().change_scene_to_file(global_var.main_menu_scene)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "music-off":
		animation_player.play("aftermatch")

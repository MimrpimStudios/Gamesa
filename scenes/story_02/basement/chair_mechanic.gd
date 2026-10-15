extends Node

@onready var player: CharacterBody2D = $"../Player"
@onready var player_animated_sprite_2d: AnimatedSprite2D = $"../Player/AnimatedSprite2D"
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $"../Label"

const PLAYER_ROPE_CHAIR_BROKEN = preload("uid://c3y05odf08dpn")

# Původní text si uložíme jako šablonu
const BASE_TEXT: String = "Jump %d times \nto be free..."

var jump_count: int = 0
var is_changing_scene: bool = false

func _ready() -> void:
	await get_tree().process_frame
	global_var.player_movement = false
	
	# Posed hráče nastavíme jednoduše jednou na začátku
	player.hide()
	player.position = Vector2(8.0, -10.0)
	player_animated_sprite_2d.animation = "sitting_couch"
	
	# Nastavíme výchozí text na začátku (vyjde z toho "Jump 5 times \nto be free...")
	update_label()

func _input(event: InputEvent) -> void:
	if is_changing_scene:
		return
		
	if event.is_action_pressed("jump"):
		if jump_count < 5:
			jump_count += 1
			update_label()
			
			# Po pátém skoku spustíme přechod
			if jump_count >= 5:
				change_to_next_scene()

func update_label() -> void:
	var remaining_jumps: int = 5 - jump_count
	# Pomocí %d dosadíme aktuální číslo do textu
	label.text = BASE_TEXT % remaining_jumps

func change_to_next_scene() -> void:
	is_changing_scene = true
	await get_tree().process_frame
	get_tree().change_scene_to_file(global_var.story_2_basement_1_no_chair_scene)

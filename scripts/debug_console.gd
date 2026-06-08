extends CanvasLayer

var is_open: bool = false

var commands = [
	"help",
	"clear",
	"speed",
	"god"
]
var syntax = [
	" - Shows all available commands",
	" - Clears console",
	" <set|reset> <float> - Sets the player speed",
	" - Enable god mode (can not turn off, only by killing itself)"
]

@onready var root: CanvasLayer = $"."
@onready var label: Label = $UI_Container/Panel/Label
@onready var rich_text_label: RichTextLabel = $UI_Container/Panel/RichTextLabel
@onready var line_edit: LineEdit = $UI_Container/Panel/LineEdit
@onready var ui_container: Control = $UI_Container
@onready var panel: Panel = $UI_Container/Panel

var player = null
# Proměnná pro uložení původního režimu myši před otevřením konzole
var PREVIOUS_MOUSE_MODE = Input.MOUSE_MODE_CAPTURED 

func _ready() -> void:
	root.hide() # Na začátku hru startujeme se skrytou konzolí

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("console"):
		is_open = !is_open # Prohodí true/false
		
		if is_open:
			# OTEVŘENÍ KONZOLE
			PREVIOUS_MOUSE_MODE = Input.mouse_mode # Uložíme si, jak to měl hráč předtím
			root.show()
			line_edit.clear()
			line_edit.grab_focus()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			global_var.player_movement = false
		else:
			# ZAVŘENÍ KONZOLE
			root.hide()
			Input.mouse_mode = PREVIOUS_MOUSE_MODE # Vrátíme myš do původního stavu
			global_var.player_movement = true

func _on_line_edit_text_submitted(text: String) -> void:
	text = text.strip_edges() # Odstraní nechtěné mezery na začátku/konci
	if text == "":
		return
		
	var command = text.get_slice(" ", 0)
	var arg1 = text.get_slice(" ", 1)
	var arg2 = text.get_slice(" ", 2)

	if not command in commands:
		rich_text_label.append_text("Invalid command " + command + "\n")
		rich_text_label.append_text("Type help for list of commands\n")
		
	elif command == "help":
		rich_text_label.append_text("Available commands: \n")
		for i in range(commands.size()):
			rich_text_label.append_text(commands[i] + syntax[i] + "\n")
			
	elif command == "clear":
		rich_text_label.clear()
		
	elif command == "speed":
		player = get_tree().get_first_node_in_group("player") as CharacterBody2D
		
		if not player:
			rich_text_label.append_text("Player does not exist\n")
		elif arg1 == "reset":
			player.SPEED = 150.0
			rich_text_label.append_text("Player speed is now " + str(player.SPEED) + "\n")
		elif arg1 == "set" and arg2.is_valid_float():
			player.SPEED = float(arg2)
			rich_text_label.append_text("Player speed is now " + str(player.SPEED) + "\n")
		else:
			rich_text_label.append_text("Syntax: " + commands[2] + syntax[2] + "\n")
			
	elif command == "god":
		global_var.player_max_health = 999
		global_var.player_health = 999
		rich_text_label.append_text("Godmode on\n")
	
	# Vyčistíme text box a necháme v něm kurzor pro další psaní
	line_edit.clear()
	line_edit.call_deferred("grab_focus")

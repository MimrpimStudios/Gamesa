extends CanvasLayer

var shown: bool = false
var commands = [
	"help",
	"clear",
	"speed"
]
var syntax = [
	" - Shows all avalable commands",
	" - Clears console",
	" <set|reset> <number> - Sets the player speed (good for need to go fast)"
]
@onready var root: CanvasLayer = $"."
@onready var label: Label = $Panel/Label
@onready var rich_text_label: RichTextLabel = $Panel/RichTextLabel
@onready var line_edit: LineEdit = $Panel/LineEdit

var player = null
var mouse_visible: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		mouse_visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if shown:
		root.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		root.hide()
		if not mouse_visible:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("console"):
		if shown:
			shown = false
		else:
			shown = true


func _on_line_edit_text_submitted(text: String) -> void:
	var command = text.get_slice(" ", 0)
	var arg1 = text.get_slice(" ", 1)
	var arg2 = text.get_slice(" ", 2)

	if not command in commands:
		line_edit.text = ""
		rich_text_label.append_text("Invalid command " + command + "\n")
		rich_text_label.append_text("Type help for list of commands" + "\n")
	elif command == "help":
		line_edit.text = ""
		rich_text_label.append_text("Avalable commands: \n\n")
		var counter_commands: int = 0
		for item in commands:
			rich_text_label.append_text(item + syntax[counter_commands] + "\n")
			counter_commands += 1
	elif command == "clear":
		line_edit.text = ""
		rich_text_label.text = ""
	elif command == "speed":
		line_edit.text = ""
		player = get_tree().get_first_node_in_group("hrac")
		if arg1 == "reset":
			if player:
				player.SPEED = 150.0
				rich_text_label.append_text("Player speed is now " + str(player.SPEED) + "\n")
			else:
				rich_text_label.append_text("Player does not exist" + "\n")
				
		else:
			rich_text_label.append_text("Syntax: " + commands[2] + syntax[2] + "\n")

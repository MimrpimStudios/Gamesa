extends Control

@onready var continue_game_button: TextureButton = $GameChoosePanel/ContinueGameButton
@onready var game_choose_panel: Panel = $GameChoosePanel
@onready var texture_button_play: TextureButton = $TextureButtonPlay
@onready var texture_button_exit: TextureButton = $TextureButtonExit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	print(str(global_var.load_level()))
	panel_hide()
	if global_var.load_level() == global_var.start_scene_story:
		continue_game_button.set_disabled(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_texture_button_play_pressed() -> void:
	panel_show()

	# Old use
	# global_var.level = global_var.load_level()
	# print(global_var.level)
	#get_tree().change_scene_to_file(global_var.level)


func _on_texture_button_exit_pressed() -> void:
	get_tree().quit(0)


func _on_new_game_button_pressed() -> void:
	global_var.level = global_var.start_scene_story
	print("Going to: " + str(global_var.level))
	get_tree().change_scene_to_file(global_var.level)


func _on_continue_game_button_pressed() -> void:
	global_var.level = global_var.load_level()
	print("Going to: " + str(global_var.level))
	get_tree().change_scene_to_file(global_var.level)


func _on_back_button_pressed() -> void:
	panel_hide()


func panel_show():
	texture_button_exit.hide()
	texture_button_play.hide()
	game_choose_panel.show()


func panel_hide():
	texture_button_exit.show()
	texture_button_play.show()
	game_choose_panel.hide()

extends Control

@onready var PlayButton = $PlayButton
@onready var ExitButton = $ExitButton
@onready var GithubLinkButton = $GithubLinkButton
@onready var music = $AudioStreamPlayer

const start_scene = "res://scenes/Levels/Level1.tscn"
const github_link = "https://github.com/mimrpim/Gamesa/"
const github_wiki_link = "https://github.com/mimrpim/Gamesa/wiki"
const github_web_link = "https://mimrpim/github.io/Gamesa"

func _ready() -> void:
	print("[INFO/MAIN_MENU] Playing music")
	music.play()

func _on_play_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Play button")
	print("[INFO/MAIN_MENU] Starting scene" + start_scene)
	get_tree().change_scene_to_file(start_scene)

func _on_exit_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Exit button")
	print("[INFO/MAIN_MENU] Exiting the game")
	get_tree().quit()


func _on_github_link_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Github link button")
	print("[INFO/MAIN_MENU] Opening " + github_link)
	OS.shell_open(github_link)


func _on_wiki_link_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Github Wiki link button")
	print("[INFO/MAIN_MENU] Opening " + github_wiki_link)
	OS.shell_open(github_wiki_link)
func _on_web_link_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Github Web link button")
	print("[INFO/MAIN_MENU] Opening " + github_web_link)
	OS.shell_open(github_web_link)

extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	OS.shell_open("https://libresprite.github.io/")


func _on_texture_button_2_pressed() -> void:
	OS.shell_open("https://godotengine.org")


func _on_texture_button_3_pressed() -> void:
	OS.shell_open("https://mimrpim.itch.io/Gamesa")


func _on_texture_button_4_pressed() -> void:
	OS.shell_open("https://github.com/mimrpimstudios/gamesa")

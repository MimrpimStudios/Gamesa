extends Node

@onready var line_edit: LineEdit = $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_join_pressed() -> void:
	MultiplayerLoader.join_game(line_edit.text)


func _on_host_pressed() -> void:
	MultiplayerLoader.host_game()


func _on_start_pressed() -> void:
	pass # Replace with function body.

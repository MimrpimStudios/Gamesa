extends Area2D

@onready var tobik_hut_button: Button = $"../TobikHutButton"

const tobik_hut_scene = "res://scenes/Levels/tobik_hut1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_exited(body: Node2D) -> void:
	tobik_hut_button.hide()


func _on_body_entered(body: Node2D) -> void:
	tobik_hut_button.show()

func _on_tobik_hut_button_pressed() -> void:
	get_tree().change_scene_to_file(tobik_hut_scene)
	

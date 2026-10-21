extends Area2D

var repeat4 = false
@export var work: bool = false
@onready var label: Label = $"../Player/Label"

func _ready() -> void:
	label.hide()

func _on_body_exited(_body: Node2D) -> void:
	repeat4 = false
	label.hide()


func _on_body_entered(_body: Node2D) -> void:
	repeat4 = true
	if work:
		label.show()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("integrate") and repeat4 and work:
		get_tree().change_scene_to_file(global_var.town_02_back_home_scene)

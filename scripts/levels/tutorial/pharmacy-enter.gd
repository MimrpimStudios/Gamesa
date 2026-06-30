extends Area2D

var repeat5 = false

@onready var label: Label = %Label

func _ready() -> void:
	label.hide()

func _on_body_exited(_body: Node2D) -> void:
	repeat5 = false
	label.hide()


func _on_body_entered(_body: Node2D) -> void:
	repeat5 = true
	label.show()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("integrate") and repeat5:
		get_tree().change_scene_to_file(global_var.pharmacy_in_01_scene)

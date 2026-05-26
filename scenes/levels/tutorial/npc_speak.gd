extends Area2D


@onready var npc: CharacterBody2D = $"../PharmacyMale"
var speak = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if speak and Input.is_action_just_pressed("integrate"):
		npc.dialog_01()


func _on_body_entered(_body: Node2D) -> void:
	speak = true


func _on_body_exited(_body: Node2D) -> void:
	speak = false

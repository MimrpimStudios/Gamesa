extends Area2D

@export var scene: PackedScene
@export var work: bool = true
var entered: bool
@onready var label: Label = $"../Player/Label"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("integrate") and entered:
		if not scene == null:
			get_tree().change_scene_to_packed(scene)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		entered = true
	label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		entered = false
	%Label.hide()

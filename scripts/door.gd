extends Area2D
## An object in editor, that is used for changing scenes, if player interacts with them

## A scene when the door is used. Leave <empty> for disabling them.
@export var scene: PackedScene

var entered: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("integrate") and entered:
		get_tree().change_scene_to_packed(scene)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		entered = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		entered = false

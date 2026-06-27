extends Area2D

## A scene when is entered into the area
@export var scene: PackedScene


@onready var collision: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_packed(scene)

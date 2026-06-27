extends Area2D
## An object in editor, that is used for changing scenes, if player interacts with them

## A scene when the door is used. Leave <empty> for disabling them.
@export var scene: PackedScene
@export_group("Texture")
## A texture used when the door is active
@export var door_texture: Texture2D = preload("uid://cmeo2j124jyhm")
## A texture when the door is disabled
@export var door_texture_disabled: Texture2D = preload("uid://byiq3ml1gstxt")


var entered: bool = false

@onready var sprite: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if scene == null:
		sprite.set_texture(door_texture_disabled)
	else:
		sprite.set_texture(door_texture)


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

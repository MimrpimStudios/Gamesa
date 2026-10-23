extends Area2D

@export var scene: PackedScene
@export var work: bool = true
@export_group("Texture")
@export var normal_texture:CompressedTexture2D = preload("uid://cmeo2j124jyhm")
@export var locked_texture:CompressedTexture2D = preload("uid://byiq3ml1gstxt")

var entered: bool
@onready var label: Label = $"../Player/Label"
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if work:
		if not sprite_2d.texture == normal_texture:
			sprite_2d.texture = normal_texture
	else:
		if not sprite_2d.texture == locked_texture:
			sprite_2d.texture = locked_texture

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("integrate") and entered and work:
		if not scene == null:
			get_tree().change_scene_to_packed(scene)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and work:
		entered = true
		label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		entered = false
		label.hide()

extends Control

@onready var label: Label = $LabelVersion
@onready var label_fps: Label = $LabelFPS
@onready var version = global_var.version
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "Gamesa version: " + ProjectSettings.get_setting("application/config/version") + " or version: " + version


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label_fps.text = "FPS: " + str(Engine.get_frames_per_second())

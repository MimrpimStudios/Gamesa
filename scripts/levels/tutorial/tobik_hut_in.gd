extends Area2D

@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	audio_stream_player.stream = preload("uid://b7mdtuj52smgl")
	audio_stream_player.play()

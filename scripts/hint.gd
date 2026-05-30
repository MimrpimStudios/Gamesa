extends Node2D

@onready var speak_npc: Label = $SpeakNPC


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if global_var.player_show_speakNPC:
		speak_npc.show()
	else:
		speak_npc.hide()

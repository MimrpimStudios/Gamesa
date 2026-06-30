extends Label

@onready var dialog: Label = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog.text = ""
	label_settings.set_font_color(global_var.player_show_speakNPC_color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

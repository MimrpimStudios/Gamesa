extends AcceptDialog

@onready var popup_win: AcceptDialog = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	popup_win.hide()
	if global_var.launcher_type == "":
		print("showing popup")
		popup_win.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_confirmed() -> void:
	OS.shell_open("https://github.com/MimrpimStudios/gamesa-launcher/releases/tag/1.0.0.0-GUI")

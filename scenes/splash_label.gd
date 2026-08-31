extends Label

const SPLASHES_FILE = "res://assets/texts/splashes.txt"

func _ready() -> void:
	if FileAccess.file_exists(SPLASHES_FILE):
		var file = FileAccess.open(SPLASHES_FILE, FileAccess.READ)
		var content = file.get_as_text()
		var splashes = Array(content.split("\n", false))
		
		if not splashes.is_empty():
			text = splashes.pick_random()

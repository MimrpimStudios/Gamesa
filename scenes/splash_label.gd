extends Label

const SPLASHES_FILE = "res://assets/texts/splashes.txt"
var rng = RandomNumberGenerator.new()
var splashes = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	var file = FileAccess.open(SPLASHES_FILE, FileAccess.READ)
	var content = file.get_as_text()
	for i in content.split("\n", false):
		splashes.append(i)
	var int_num = rng.randi_range(1, splashes.size())
	text = splashes[int_num]

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 100:
		print("ready for " + str(i + 1) + ". time")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pressed() -> void:
	$"../AudioStreamPlayer".stream = preload("uid://d4gjr1eychf27")
	$"../AudioStreamPlayer".play()

extends Node

var showed = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	if showed:
		$Label.size = Vector2(112.0, 31.0)
		$Label.position = Vector2(3212.5, 2755.0)
		$Label.text = "IT LOOKS LIKE I AM
	IN THE SEWERS..."
		$Timer.start(5)
		showed = false
	else:
		$Label.text = ""
		$Label.hide()
		get_tree().change_scene_to_file(global_var.stoky_no_monolog_scene)

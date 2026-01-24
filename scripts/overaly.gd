extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("hide_overaly"):
		if global_var.hide_overaly:
			global_var.hide_overaly = false
			show_everything_child()
		else:
			global_var.hide_overaly = true
			hide_everything_child()

func hide_everything_child():
	# "*" najde všechny uzly, "CanvasItem" odfiltruje ty, co lze skrýt
	var all_children = find_children("*")
	for child in all_children:
		child.hide() # hide() je totéž co visible = false

func show_everything_child():
	# "*" najde všechny uzly, "CanvasItem" odfiltruje ty, co lze skrýt
	var all_children = find_children("*")
	for child in all_children:
		child.show() # hide() je totéž co visible = false

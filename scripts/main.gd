extends Control

@onready var timer: Timer = $Timer
var launcher_type = ""
var launcher_version = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_launcher_info()
	if launcher_type != "":
		if launcher_type == "GUI":
			print("you using gui")
			print(launcher_version)
		elif launcher_type == "CLI":
			print("you using cli")
			print(launcher_version)
		else:
			print("you liar")
			timer.wait_time = 10

	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print("changing scene to: " + global_var.start_scene)
	get_tree().change_scene_to_file(global_var.start_scene)


func get_launcher_info():
	print("=".repeat(30))
	var args = OS.get_cmdline_args()
	var args_user = OS.get_cmdline_user_args()
	
	print("arguments: " + str(args))
	print("user arguments: " + str(args_user))
	
	if args.has("-launcherCLI"):
		print("-".repeat(30))
		print("Spusteno pres CLI launcher.")
		launcher_type = "CLI"
		
		var version_value = get_arg_value(args, "-versionCLI")
		
		if version_value != "":
			print("CLI version: " + version_value)
			launcher_version = version_value
		print("-".repeat(30))
	if args.has("-launcherGUI"):
		print("-".repeat(30))
		print("Spusteno pres GUI launcher.")
		launcher_type = "GUI"
		var version_value_gui = get_arg_value(args, "-versionGUI")
		
		if version_value_gui != "":
			print("GUI version: " + version_value_gui)
			launcher_version = version_value_gui
		
		print("-".repeat(30))
		
	print("=".repeat(30))

func get_arg_value(argument_list: PackedStringArray, prefix: String) -> String:
	for arg in argument_list:
		if arg.begins_with(prefix + "="):
			return arg.split("=")[1] 
	return ""

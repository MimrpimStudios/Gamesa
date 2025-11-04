extends Control

# --- UZLY (SPLASH SCREEN) ---
@onready var timer = $Timer
@onready var animationplayer = $AnimationPlayer

# --- KONSTANTY (UNIFIKOVANÉ) ---
const MainMenu_scene = "res://scenes/MainMenu/MainMenu.tscn"
# Používáme .dat pro binární soubory nastavení
const SAVE_PATH = "user://settings.dat" 

# MAPA ROZLIŠENÍ: Odstraněno, protože Fullscreen ignoruje nastavení v Godot 4.

# --- TŘÍDNÍ PROMĚNNÉ (Nastavení) ---
# Defaultní hodnoty (budou přepsány, pokud se načte soubor)
# mode_video: 0 = Fullscreen (Borderless), 1 = Windowed
var mode_video = 0 
# resolution_video: Odstraněno.


# ========================================================================
# --- ŽIVOTNÍ CYKLUS (INIT A SPLASH START) ---
# ========================================================================

func _ready() -> void:
	# 1. Načíst uložené nastavení (pokud existuje)
	_load_settings()
	
	# 2. APLIKOVAT NASTAVENÍ OKNA HRY S OPOŽDĚNÍM
	# call_deferred zajišťuje, že se kód nespustí uprostřed inicializace.
	call_deferred("_apply_video_settings")
	
	print("[INFO/SETTINGS_LOADER] Settings load initiated.")
	
	# 3. Spustit logiku Splash Screenu
	set_process_input(true)
	print("[INFO/SPLASH] Starting splash video")
	
	# BEZPEČNOSTNÍ KONTROLA: Zabrání chybě 'null instance', pokud uzel chybí
	if is_instance_valid(animationplayer):
		animationplayer.play("fade_out")
	else:
		print("[WARN/SPLASH] AnimationPlayer not found. Splash fade will not play.")


# ========================================================================
# --- SPLASH SCREEN LOGIKA ---
# ========================================================================

# Změna scény po vypršení časovače
func _on_timer_timeout():
	get_tree().change_scene_to_file(MainMenu_scene)
	print("[INFO/SPLASH] Splash ended. Starting " + MainMenu_scene)

# Změna scény po stisku jakékoliv klávesy/tlačítka
func _input(ev):
	if Input.is_anything_pressed() == true:
		print("[INFO/SPLASH] Registrated input: " + str(ev) + " so splash ended, stopping timer and Starting " + MainMenu_scene)
		
		# BEZPEČNOSTNÍ KONTROLA: Zabrání chybě 'null instance'
		if is_instance_valid(timer):
			timer.stop()
		
		get_tree().change_scene_to_file(MainMenu_scene)


# ========================================================================
# --- FUNKCE PRO NAČÍTÁNÍ A APLIKACI NASTAVENÍ ---
# ========================================================================

func _load_settings() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		print(tr("[INFO/LOAD] Settings file found. Loading data..."))
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		
		if file:
			# Načíst proměnné, které zůstaly (pouze Mode)
			# resolution_video = file.get_var() - Odstraněno
			mode_video = file.get_var() # Načítá se až druhá proměnná z uloženého souboru
			file.close()
			
			# Poznámka: Pokud soubor nastavení obsahuje staré rozlišení, je nutné ho v tomto souboru přeskočit!
			# Proto je nejlepší smazat soubor settings.dat a nechat ho vytvořit znovu, nebo v Menu nastavení upravit ukládání.
			
			print(tr("[DEBUG/LOAD] Loaded Mode ID: ") + str(mode_video))
		else:
			print(tr("[ERROR/LOAD] Failed to open settings file for reading."))
	else:
		print(tr("[INFO/LOAD] No saved data found. Using default settings."))
		# Ponecháme defaultní hodnoty

func _apply_video_settings() -> void:
	# KLÍČOVÁ OPRAVA: Počkat na další snímek, aby byl SceneTree plně inicializován
	await get_tree().process_frame
	
	var mode_to_set: int

	# 1. Nastavit cílový režim
	match mode_video:
		# Standardní FULLSCREEN (Borderless)
		0: mode_to_set = DisplayServer.WINDOW_MODE_FULLSCREEN 
		1: mode_to_set = DisplayServer.WINDOW_MODE_WINDOWED
		_: mode_to_set = DisplayServer.WINDOW_MODE_FULLSCREEN 

	# 2. Nastavit V-Sync (opravená implementace pro Godot 4)
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	
	# 3. Nastavit režim okna
	DisplayServer.window_set_mode(mode_to_set)
	print(tr("[INFO/SETTINGS] Applied window mode ID: ") + str(mode_video) + " (" + str(mode_to_set) + ")")
	
	# 4. Centrování POUZE pro WINDOWED režim a zjednodušená logika pro FULLSCREEN
	if mode_to_set == DisplayServer.WINDOW_MODE_WINDOWED:
		# Centrovat okno
		# Používáme aktuální velikost okna, jelikož jsme ji nenačetli ze souboru
		var current_size = DisplayServer.window_get_size()
		DisplayServer.window_set_position(DisplayServer.screen_get_size() / 2 - current_size / 2)
		print(tr("[INFO/SETTINGS] Window centered."))
	elif mode_to_set == DisplayServer.WINDOW_MODE_FULLSCREEN:
		# Jednoduché vynucení aktualizace pro standardní Fullscreen
		await get_tree().process_frame
		print(tr("[INFO/SETTINGS] Standard Fullscreen mode set. Stabilization complete."))
	
	print("[INFO/SETTINGS_LOADER] Settings applied successfully.")

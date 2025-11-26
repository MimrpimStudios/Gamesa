extends Control

# --- KONSTANTY ---
const START_SCENE = "res://scenes/Levels/Tutorial1/Tutorial1_house.tscn"
const GITHUB_LINK = "https://github.com/mimrpim/Gamesa/"
const GITHUB_WIKI_LINK = "https://github.com/mimrpim/Gamesa/wiki"
const GITHUB_WEB_LINK = "https://mimrpim.github.io/Gamesa"
const SAVE_PATH = "user://settings.dat"
const SAVE_PATH_SCENE = "user://scene.save"
const DEFAULT_START_SCENE = "res://scenes/Levels/Tutorial1/Tutorial1_house.tscn"
var current_scene_to_load: String = DEFAULT_START_SCENE
# --- AUDIO KONSTANTY (Názvy Busů) ---
# Ujistěte se, že tyto názvy odpovídají vašim Audio Busům!
const MASTER_BUS_NAME = "Master"
const MUSIC_BUS_NAME = "Music"
const SFX_BUS_NAME = "SFX"

# --- TŘÍDNÍ PROMĚNNÉ (Nastavení) ---
# Třídní proměnné pro indexy busů, inicializace proběhne v _ready().
var MASTER_BUS_INDEX: int = -1
var MUSIC_BUS_INDEX: int = -1
var SFX_BUS_INDEX: int = -1

# Třídní proměnné, které drží aktuální stav nastavení
var mode_video = 0
var volume_master = 100.0 # Nová proměnná pro Master
var volume_music = 100.0
var volume_sfx = 100.0 # Nová proměnná pro SFX

# --- UZLY (Node References) ---
@onready var music: AudioStreamPlayer = $Music
@onready var back_ground: ColorRect = $BackGround
@onready var back_video: VideoStreamPlayer = $BackVideo
@onready var buttons: Node = $Buttons
@onready var play_button: Button = $Buttons/PlayButton
@onready var advancements_button: Button = $Buttons/AdvancementsButton
@onready var settings_button: Button = $Buttons/SettingsButton
@onready var exit_button: Button = $Buttons/ExitButton
@onready var wiki_link_button: Button = $Links/WikiLinkButton
@onready var github_link_button: Button = $Links/GithubLinkButton
@onready var web_link_button: Button = $Links/WebLinkButton
@onready var settings_panel: Panel = $SettingsPanel
@onready var general_button: Button = $SettingsPanel/GeneralButton
@onready var music_button: Button = $SettingsPanel/MusicButton
@onready var video_button: Button = $SettingsPanel/VideoButton
@onready var back_button_options: Button = $SettingsPanel/BackButtonOptions
@onready var music_panel: Panel = $MusicPanel
@onready var volume_label_music: Label = $MusicPanel/VolumeLabelMusic
@onready var volume_slider_master: HSlider = $MusicPanel/VolumeSliderMaster
@onready var back_button_music: Button = $MusicPanel/BackButtonMusic
@onready var video_settings_panel: Panel = $VideoSettingsPanel
@onready var back_button_video: Button = $VideoSettingsPanel/BackButtonVideo
@onready var mode_button_video: OptionButton = $VideoSettingsPanel/ModeButtonVideo
@onready var volume_slider_music: HSlider = $MusicPanel/VolumeSliderMusic
@onready var volume_label_sfx: Label = $MusicPanel/VolumeLabelSFX
@onready var volume_slider_sfx: HSlider = $MusicPanel/VolumeSliderSFX


# ========================================================================
# --- ŽIVOTNÍ CYKLUS ---
# ========================================================================

func _ready() -> void:
	# --- AUDIO INIT: Získání indexů busů po inicializaci SceneTree ---
	MASTER_BUS_INDEX = AudioServer.get_bus_index(MASTER_BUS_NAME)
	MUSIC_BUS_INDEX = AudioServer.get_bus_index(MUSIC_BUS_NAME)
	SFX_BUS_INDEX = AudioServer.get_bus_index(SFX_BUS_NAME)
	if MUSIC_BUS_INDEX == -1:
		push_warning("Audio Bus '" + MUSIC_BUS_NAME + "' not found. Music volume control will not work.")
	if MASTER_BUS_INDEX == -1:
		push_warning("Audio Bus '" + MASTER_BUS_NAME + "' not found. Master volume control will not work.")
	if SFX_BUS_INDEX == -1:
		push_warning("Audio Bus '" + SFX_BUS_NAME + "' not found. SFX volume control will not work.")
	# -------------------------------------------------------------------
	
	# 1. Načíst nastavení hned po spuštění! (Potlačí defaultní hodnoty)
	_load_settings()
	_load_scene_path()
	print("[INFO/MAIN_MENU] Playing music")
	
	# 2. Aplikovat načtené hodnoty na UI prvky
	# VSYNC by se mělo nastavit co nejdříve
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	mode_button_video.selected = mode_video
	
	# --- INICIALIZACE AUDIO SLIDERŮ ---
	# Aplikujeme načtené hodnoty na Slidery
	volume_slider_master.value = volume_master
	volume_slider_music.value = volume_music
	volume_slider_sfx.value = volume_sfx
	
	# --- OPRAVA: PŘIPOJENÍ AudioStreamPlayer k "Music" BUSU ---
	# Zajišťuje, že hudba jde přes správnou sběrnici, kterou řídíme sliderem.
	if MUSIC_BUS_INDEX != -1:
		music.bus = MUSIC_BUS_NAME
		print("[INFO/MAIN_MENU] Music player assigned to bus: " + MUSIC_BUS_NAME)
	else:
		# Fallback na Master, pokud Music bus neexistuje (mělo by být ošetřeno warningem)
		music.bus = MASTER_BUS_NAME
		print("[WARN/MAIN_MENU] Music player assigned to Master bus (Music bus not found).")
	# -----------------------------------------------------------
	
	# Aplikujeme hlasitost IHNED po načtení
	_apply_audio_settings()
	music.play()
	# ----------------------------------------
	
	# Původní funkce set_slider_value() byla odstraněna, protože cílila na špatný slider.
	
	# 3. Zobrazení/Skrytí panelů a tlačítek
	settings_panel.hide()
	video_settings_panel.hide()
	play_button.show()
	settings_button.show()
	advancements_button.show()
	exit_button.show()
	music_panel.hide()

# Původní funkce set_slider_value() byla odstraněna, protože cílila na špatný slider (volume_slider_master).

# Zpracování klávesnice pro stisk ESC (Konec hry)
func _input(event):
	if Input.is_action_just_pressed("esc"):
		print("[DEBUG/MAIN_MENU] Pressed "+str(event)+" button")
		print("[INFO/MAIN_MENU] Exiting the game")
		get_tree().quit()

func _save_scene_path(path_to_save: String) -> void:
	var file = FileAccess.open(SAVE_PATH_SCENE, FileAccess.WRITE)
	
	if file:
		file.store_var(path_to_save)
		# file.close() # Godot 4: Není nutné
		print(tr("[INFO/MAIN_MENU] Scene path saved: ") + path_to_save)
	else:
		print(tr("[ERROR/MAIN_MENU] Failed to save scene path to: ") + SAVE_PATH_SCENE)

# NOVÁ FUNKCE: Pro načtení cesty k aktuální scéně
func _load_scene_path() -> void:
	if FileAccess.file_exists(SAVE_PATH_SCENE):
		var file = FileAccess.open(SAVE_PATH_SCENE, FileAccess.READ)
		
		if file:
			var loaded_path = file.get_var()
			
			# Kontrola, že načtená hodnota je platný řetězec a není prázdná
			if typeof(loaded_path) == TYPE_STRING and not loaded_path.is_empty():
				current_scene_to_load = loaded_path
				print(tr("[INFO/MAIN_MENU] Loaded saved scene path: ") + current_scene_to_load)
			else:
				print(tr("[WARN/MAIN_MENU] Saved scene path was invalid or empty, using default: ") + DEFAULT_START_SCENE)
		else:
			print(tr("[ERROR/MAIN_MENU] Failed to open scene path file for reading."))
	else:
		print(tr("[INFO/MAIN_MENU] No saved scene path found. Using default: ") + DEFAULT_START_SCENE)


# ========================================================================
# --- FUNKCE PRO UKLÁDÁNÍ, NAČÍTÁNÍ A APLIKACI NASTAVENÍ ---
# ========================================================================

func _save_settings() -> void:
	# Otevře soubor pro ZÁPIS. Režim WRITE soubor vytvoří nebo vymaže.
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	if file:
		# Získat aktuální vybrané hodnoty z UI prvků do třídních proměnných
		mode_video = mode_button_video.get_selected_id()
		volume_master = volume_slider_master.value
		volume_music = volume_slider_music.value
		volume_sfx = volume_slider_sfx.value
		
		# Uložit proměnné JEDNU PO DRUHÉ (musí se číst v tomto pořadí)
		# POZOR NA POŘADÍ UKLÁDÁNÍ!
		file.store_var(mode_video)
		file.store_var(volume_master)
		file.store_var(volume_music)
		file.store_var(volume_sfx) # Ukládáme SFX
		
		# ZAVŘÍT SOUBOR! Kritické pro zapsání na disk.
		file.close()
		print(tr("[INFO/SAVE] Settings saved. Mode: ") + str(mode_video) + tr(", Master Vol: ") + str(volume_master) + tr(", Music Vol: ") + str(volume_music) + tr(", SFX Vol: ") + str(volume_sfx))
	else:
		print(tr("[ERROR/SAVE] Failed to save settings to: ") + SAVE_PATH)

func _load_settings() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		
		if file:
			# Načíst proměnné ve stejném pořadí, v jakém byly uloženy
			
			# 1. Video Mode
			if not file.eof_reached():
				var loaded_mode = file.get_var()
				if loaded_mode != null and typeof(loaded_mode) == TYPE_INT:
					mode_video = loaded_mode
				else:
					print(tr("[ERROR/LOAD] Failed to decode mode_video. Using default."))

			# 2. Master Volume
			if not file.eof_reached():
				var loaded_volume_master = file.get_var()
				if loaded_volume_master != null and typeof(loaded_volume_master) in [TYPE_FLOAT, TYPE_INT]:
					volume_master = loaded_volume_master
				else:
					print(tr("[ERROR/LOAD] Failed to decode volume_master. Using default."))

			# 3. Music Volume
			if not file.eof_reached():
				var loaded_volume_music = file.get_var()
				if loaded_volume_music != null and typeof(loaded_volume_music) in [TYPE_FLOAT, TYPE_INT]:
					volume_music = loaded_volume_music
				else:
					print(tr("[ERROR/LOAD] Failed to decode volume_music. Using default."))
			
			# 4. SFX Volume
			if not file.eof_reached():
				var loaded_volume_sfx = file.get_var()
				if loaded_volume_sfx != null and typeof(loaded_volume_sfx) in [TYPE_FLOAT, TYPE_INT]:
					volume_sfx = loaded_volume_sfx
				else:
					print(tr("[ERROR/LOAD] Failed to decode volume_sfx. Using default."))
			
			file.close()
			
			print(tr("[DEBUG/LOAD] Loaded Mode ID: ") + str(mode_video))
			print(tr("[DEBUG/LOAD] Loaded Master Volume: ") + str(volume_master))
			print(tr("[DEBUG/LOAD] Loaded Music Volume: ") + str(volume_music))
			print(tr("[DEBUG/LOAD] Loaded SFX Volume: ") + str(volume_sfx))
		else:
			print(tr("[ERROR/LOAD] Failed to open settings file for reading."))
	else:
		print(tr("[INFO/LOAD] No saved data found. Using default settings."))
		# Ponecháme defaultní hodnoty

func _apply_audio_settings() -> void:
	# APLIKACE MASTER HLASITOSTI
	if MASTER_BUS_INDEX != -1:
		var linear_volume = volume_master / 100.0
		var db_volume = linear_to_db(linear_volume)
		AudioServer.set_bus_volume_db(MASTER_BUS_INDEX, db_volume)
		print(tr("[INFO/AUDIO] Applied Master Volume: ") + str(volume_master) + tr(" (") + str(db_volume) + " dB)")
	else:
		print(tr("[WARN/AUDIO] Master bus not found! Check AudioBusLayout."))
	
	# APLIKACE MUSIC HLASITOSTI
	if MUSIC_BUS_INDEX != -1:
		var linear_volume = volume_music / 100.0
		var db_volume = linear_to_db(linear_volume)
		AudioServer.set_bus_volume_db(MUSIC_BUS_INDEX, db_volume)
		print(tr("[INFO/AUDIO] Applied Music Volume: ") + str(volume_music) + tr(" (") + str(db_volume) + " dB)")
	else:
		print(tr("[WARN/AUDIO] Music bus not found! Check AudioBusLayout."))

	# APLIKACE SFX HLASITOSTI
	if SFX_BUS_INDEX != -1:
		var linear_volume = volume_sfx / 100.0
		var db_volume = linear_to_db(linear_volume)
		AudioServer.set_bus_volume_db(SFX_BUS_INDEX, db_volume)
		print(tr("[INFO/AUDIO] Applied SFX Volume: ") + str(volume_sfx) + tr(" (") + str(db_volume) + " dB)")
	else:
		print(tr("[WARN/AUDIO] SFX bus not found! Check AudioBusLayout."))

# (Tato funkce zůstává v tomto skriptu pro rychlé přepínání)
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

	# 2. Nastavit režim okna
	DisplayServer.window_set_mode(mode_to_set)
	print(tr("[INFO/SETTINGS] Applied window mode ID: ") + str(mode_video) + " (" + str(mode_to_set) + ")")
	
	# 3. Centrování POUZE pro WINDOWED režim a zjednodušená logika pro FULLSCREEN
	if mode_to_set == DisplayServer.WINDOW_MODE_WINDOWED:
		# Centrovat okno
		var current_size = DisplayServer.window_get_size()
		DisplayServer.window_set_position(DisplayServer.screen_get_size() / 2 - current_size / 2)
		print(tr("[INFO/SETTINGS] Window centered."))
	elif mode_to_set == DisplayServer.WINDOW_MODE_FULLSCREEN:
		# Jednoduché vynucení aktualizace pro standardní Fullscreen
		await get_tree().process_frame
		print(tr("[INFO/SETTINGS] Standard Fullscreen mode set. Stabilization complete."))
	
	print("[INFO/SETTINGS_LOADER] Settings applied successfully.")


# ========================================================================
# --- SIGNÁLY A CALLBACKY ---
# ========================================================================

# --- Nastavení Zvuku ---

# Tato funkce je volána, když se změní hodnota volume_slider_master
func _on_volume_slider_master_value_changed(value: float) -> void:
	# OKAMŽITÁ APLIKACE HLASITOSTI PŘI POHYBU SLIDEREM
	volume_master = value # Aktualizujeme třídní proměnnou (0-100)
	_apply_audio_settings() # Aplikujeme nové decibely

# Tato funkce je volána, když se změní hodnota volume_slider_music
func _on_volume_slider_music_value_changed(value: float) -> void:
	# OKAMŽITÁ APLIKACE HLASITOSTI PŘI POHYBU SLIDEREM
	volume_music = value # Aktualizujeme třídní proměnnou (0-100)
	_apply_audio_settings() # Aplikujeme nové decibely

# Tato funkce je volána, když se změní hodnota volume_slider_sfx
func _on_volume_slider_sfx_value_changed(value: float) -> void:
	# OKAMŽITÁ APLIKACE HLASITOSTI PŘI POHYBU SLIDEREM
	volume_sfx = value # Aktualizujeme třídní proměnnou (0-100)
	_apply_audio_settings() # Aplikujeme nové decibely

# --- Hlavní tlačítka menu ---

func _on_play_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Play button")
	
	# Uložit aktuální nastavení videa/zvuku
	_save_settings()
	
	# Scénu k načtení již známe, protože byla načtena v _ready() do current_scene_to_load
	# (nebo zůstala defaultní)
	
	print("[INFO/MAIN_MENU] Starting scene: " + current_scene_to_load)
	
	# Přejdeme na scénu uloženou v proměnné current_scene_to_load
	get_tree().change_scene_to_file(current_scene_to_load)

func _on_settings_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Options button")
	settings_panel.show()
	play_button.hide()
	settings_button.hide()
	advancements_button.hide()
	exit_button.hide()

# Ostatní navigační a odkazové funkce... 

func _on_advancements_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Advancements button")

func _on_exit_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Exit button")
	_save_settings() # Uložit nastavení před ukončením
	print("[INFO/MAIN_MENU] Exiting the game")
	get_tree().quit()

# --- Tlačítka pro odkazy (OPRAVENO: Používá OS.shell_open()) ---

func _on_github_link_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Github link button")
	print("[INFO/MAIN_MENU] Opening " + GITHUB_LINK)
	OS.shell_open(GITHUB_LINK)

func _on_wiki_link_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Github Wiki link button")
	print("[INFO/MAIN_MENU] Opening " + GITHUB_WIKI_LINK)
	OS.shell_open(GITHUB_WIKI_LINK)

func _on_web_link_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Github Web link button")
	print("[INFO/MAIN_MENU] Opening " + GITHUB_WEB_LINK)
	OS.shell_open(GITHUB_WEB_LINK)


# --- Navigace v Nastavení ---

func _on_back_button_options_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Back button (Settings)")
	settings_panel.hide()
	play_button.show()
	settings_button.show()
	advancements_button.show()
	exit_button.show()

func _on_video_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Video button")
	settings_panel.hide()
	video_settings_panel.show()

func _on_back_button_video_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Back button (Video)")
	print("saving...")
	
	_save_settings()
	_apply_video_settings() # Aplikace změn videa (zůstává zde)
	
	settings_panel.show()
	video_settings_panel.hide()

func _on_back_button_music_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Back button (Music)")
	_save_settings() # Uložit hlasitost
	music_panel.hide()
	settings_panel.show()

func _on_music_button_pressed() -> void:
	music_panel.show()
	settings_panel.hide()

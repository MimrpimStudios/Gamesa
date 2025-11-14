extends Control
# constants
# links
const GITHUB_LINK = "https://github.com/mimrpim/Gamesa/"
const GITHUB_WIKI_LINK = "https://github.com/mimrpim/Gamesa/wiki"
const GITHUB_WEB_LINK = "https://mimrpim.github.io/Gamesa"
# save paths
const SAVE_PATH = "user://settings.dat"
const SAVE_PATH_SCENE = "user://scene.save"
# busses
const MASTER_BUS_NAME = "Master"
const MUSIC_BUS_NAME = "Music"
const SFX_BUS_NAME = "SFX"
# scenes
const DEFAULT_START_SCENE = "res://scenes/Levels/Tutorial1/Tutorial1_house.tscn"
# variables
# currect loades scene
var current_scene_to_load: String = DEFAULT_START_SCENE
# busses
var MASTER_BUS_INDEX: int = -1
var MUSIC_BUS_INDEX: int = -1
# video settings
var mode_video = 0
# music volume
var volume_music = 100.0
# onready
@onready var music: AudioStreamPlayer = $Music
@onready var back_ground: ColorRect = $BackGround
@onready var center_container: CenterContainer = $CenterContainer
@onready var back_video: VideoStreamPlayer = $CenterContainer/BackVideo
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
@onready var volume_slider_master: HSlider = $MusicPanel/VolumeSliderMaster # POZOR: Tento slider má divný název, měl by být pro Music
@onready var back_button_music: Button = $MusicPanel/BackButtonMusic
@onready var video_settings_panel: Panel = $VideoSettingsPanel
@onready var back_button_video: Button = $VideoSettingsPanel/BackButtonVideo
@onready var mode_button_video: OptionButton = $VideoSettingsPanel/ModeButtonVideo
@onready var volume_slider_music: HSlider = $MusicPanel/VolumeSliderMusic
@onready var volume_label_2_music: Label = $MusicPanel/VolumeLabel2Music

func _ready() -> void:
	print("[INFO/MAIN_MENU] Getting Master and Music bus index...")
	MASTER_BUS_INDEX = AudioServer.get_bus_index(MASTER_BUS_NAME)
	MUSIC_BUS_INDEX = AudioServer.get_bus_index(MUSIC_BUS_NAME)
	print("[INFO/MAIN_MENU] Master: "+str(MASTER_BUS_INDEX)+" Music: "+str(MUSIC_BUS_INDEX))
	if MUSIC_BUS_INDEX == -1:
		push_warning("[WARNING/MAIN_MENU] Audio Bus '" + str(MUSIC_BUS_NAME) + "' not found. Music volume control will not work.")
	# -------------------------------------------------------------------
	
	# 1. Načíst nastavení (hlasitost, video)
	_load_settings()
	
	# 2. Načíst uloženou scénu (pokud existuje)
	_load_scene_path() 
	
	print("[INFO/MAIN_MENU] Playing music")
	
	# 3. Aplikovat načtené hodnoty na UI prvky
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	mode_button_video.selected = mode_video
	
	# --- INICIALIZACE MUSIC SLIDERU ---
	volume_slider_music.value = volume_music
	_apply_audio_settings()
	music.play()
	# ----------------------------------------
	
	# 4. Zobrazení/Skrytí panelů a tlačítek
	print("Hiding and showing default buttons and panels...")

	settings_panel.hide()
	video_settings_panel.hide()
	play_button.show()
	settings_button.show()
	advancements_button.show()
	exit_button.show()
	music_panel.hide()

func _input(event):
	if Input.is_action_just_pressed("esc"):
		print("[DEBUG/MAIN_MENU] Pressed "+str(event)+" button")
		print("[INFO/MAIN_MENU] Exiting the game")
		get_tree().quit()

func _save_settings() -> void:
	# Otevře soubor pro ZÁPIS. Režim WRITE soubor vytvoří nebo vymaže.
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	if file:
		# Získat aktuální vybrané hodnoty z UI prvků do třídních proměnných
		mode_video = mode_button_video.get_selected_id()
		volume_music = volume_slider_music.value
		
		# Uložit proměnné JEDNU PO DRUHÉ (musí se číst v tomto pořadí)
		file.store_var(mode_video)
		file.store_var(volume_music)
		
		# ZAVŘÍT SOUBOR! Kritické pro zapsání na disk.
		# file.close() # Godot 4: Není nutné, ale neškodí
		print(tr("[INFO/MAIN_MENU] Settings saved. Mode: ") + str(mode_video) + tr(", Music Vol: ") + str(volume_music))
	else:
		print(tr("[ERROR/MAIN_MENU] Failed to save settings to: ") + SAVE_PATH)

# NOVÁ FUNKCE: Pro uložení cesty k aktuální scéně
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


func _load_settings() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		
		if file:
			# Načíst proměnné ve stejném pořadí, v jakém byly uloženy
			
			var loaded_mode = file.get_var()
			if loaded_mode != null:
				mode_video = loaded_mode
			else:
				print(tr("[ERROR/MAIN_MENU] Failed to decode mode_video. Using default."))
				
			# Kontrola, zda existuje další proměnná (pro zpětnou kompatibilitu)
			if not file.eof_reached():
				var loaded_volume = file.get_var()
				if loaded_volume != null:
					volume_music = loaded_volume
				else:
					print(tr("[ERROR/MAIN_MENU] Failed to decode volume_music. Using default."))
			
			# file.close() # Godot 4: Není nutné
			
			print(tr("[DEBUG/MAIN_MENU] Loaded Mode ID: ") + str(mode_video))
			print(tr("[DEBUG/MAIN_MENU] Loaded Music Volume: ") + str(volume_music))
		else:
			print(tr("[ERROR/MAIN_MENU] Failed to open settings file for reading."))
	else:
		print(tr("[INFO/MAIN_MENU] No saved data found. Using default settings."))

func _apply_audio_settings() -> void:
	# FUNKCE PRO APLIKACI HLASITOSTI
	if MUSIC_BUS_INDEX != -1:
		# Převod 0-100 na lineární 0.0-1.0
		var linear_volume = volume_music / 100.0
		
		# Převod lineární hodnoty na decibely (logaritmická škála)
		var db_volume = linear_to_db(linear_volume)
		
		AudioServer.set_bus_volume_db(MUSIC_BUS_INDEX, db_volume)
		
		print(tr("[INFO/MAIN_MENU] Applied Music Volume: ") + str(volume_music) + tr(" (") + str(db_volume) + " dB)")
	else:
		print(tr("[WARN/MAIN_MENU] Music bus not found! Check AudioBusLayout."))

# (Tato funkce zůstává v tomto skriptu pro rychlé přepínání)
func _apply_video_settings() -> void:
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
	print(tr("[INFO/MAIN_MENU] Applied window mode ID: ") + str(mode_video) + " (" + str(mode_to_set) + ")")
	
	# 3. Centrování POUZE pro WINDOWED režim a zjednodušená logika pro FULLSCREEN
	if mode_to_set == DisplayServer.WINDOW_MODE_WINDOWED:
		var current_size = DisplayServer.window_get_size()
		DisplayServer.window_set_position(DisplayServer.screen_get_size() / 2 - current_size / 2)
		print(tr("[INFO/MAIN_MENU] Window centered."))
	elif mode_to_set == DisplayServer.WINDOW_MODE_FULLSCREEN:
		await get_tree().process_frame
		print(tr("[INFO/MAIN_MENU] Standard Fullscreen mode set. Stabilization complete."))
	
	print("[INFO/MAIN_MENU] Settings applied successfully.")


# ========================================================================
# --- SIGNÁLY A CALLBACKY ---
# ========================================================================

# --- Nastavení Hudby ---
func _on_volume_slider_music_value_changed(value: float) -> void:
	volume_music = value
	_apply_audio_settings()


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

# TOTO NYNÍ BUDE SLOUŽIT JAKO TESTOVACÍ TLAČÍTKO PRO UKLÁDÁNÍ CESTY
func _on_advancements_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Advancements button - SAVING TEST PATH")
	# PŘEDPOKLAD: Když stiskneš Pokroky, uloží se cesta do druhé úrovně/scény.
	# Změň tuto cestu na cokoliv, co chceš, aby se uložilo.
	var new_scene_path = "res://scenes/Levels/World_2.tscn" 
	
	# Uložíme novou cestu
	_save_scene_path(new_scene_path)
	
	# Aktualizujeme current_scene_to_load pro další kliknutí na Play
	current_scene_to_load = new_scene_path
	
	print("[INFO/MAIN_MENU] New path set and saved. Next Play will load: " + current_scene_to_load)


func _on_exit_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Exit button")
	_save_settings() # Uložit nastavení před ukončením
	print("[INFO/MAIN_MENU] Exiting the game")
	get_tree().quit()

# --- Tlačítka pro odkazy ---
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
	_apply_video_settings() # Aplikace změn videa
	
	settings_panel.show()
	video_settings_panel.hide()

func _on_back_button_music_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Back button (Music)")
	_save_settings() # Uložit hlasitost
	music_panel.hide()
	settings_panel.show()

func _on_music_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Music button")
	music_panel.show()
	settings_panel.hide()

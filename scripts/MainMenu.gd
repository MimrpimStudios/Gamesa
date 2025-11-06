extends Control

# --- KONSTANTY ---
const START_SCENE = "res://scenes/Levels/Tutorial1/Tutorial1_house.tscn"
const GITHUB_LINK = "https://github.com/mimrpim/Gamesa/"
const GITHUB_WIKI_LINK = "https://github.com/mimrpim/Gamesa/wiki"
const GITHUB_WEB_LINK = "https://mimrpim.github.io/Gamesa"
const SAVE_PATH = "user://settings.dat"

# --- AUDIO KONSTANTY (Názvy Busů) ---
# Ujistěte se, že tyto názvy odpovídají vašim Audio Busům!
const MASTER_BUS_NAME = "Master"
const MUSIC_BUS_NAME = "Master"
const SFX_BUS_NAME = "SFX"

# --- TŘÍDNÍ PROMĚNNÉ (Nastavení) ---
# Třídní proměnné pro indexy busů, inicializace proběhne v _ready().
var MASTER_BUS_INDEX: int = -1
var MUSIC_BUS_INDEX: int = -1

# Třídní proměnné, které drží aktuální stav nastavení
var mode_video = 0
var volume_music = 50.0 # Nová proměnná pro ukládání/načítání hlasitosti (0-100)

# --- UZLY (Node References) ---
# Hlavní menu tlačítka
@onready var back_ground: ColorRect = $BackGround
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
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
@onready var volume_slider_master: HSlider = $MusicPanel/VolumeSliderMaster
@onready var back_button_music: Button = $MusicPanel/BackButtonMusic
@onready var video_settings_panel: Panel = $VideoSettingsPanel
@onready var back_button_video: Button = $VideoSettingsPanel/BackButtonVideo
@onready var mode_button_video: OptionButton = $VideoSettingsPanel/ModeButtonVideo



# ========================================================================
# --- ŽIVOTNÍ CYKLUS ---
# ========================================================================

func _ready() -> void:
	# --- AUDIO INIT: Získání indexů busů po inicializaci SceneTree ---
	MASTER_BUS_INDEX = AudioServer.get_bus_index(MASTER_BUS_NAME)
	MUSIC_BUS_INDEX = AudioServer.get_bus_index(MUSIC_BUS_NAME)
	
	if MUSIC_BUS_INDEX == -1:
		push_warning("Audio Bus '" + MUSIC_BUS_NAME + "' not found. Music volume control will not work.")
	# -------------------------------------------------------------------
	
	# 1. Načíst nastavení hned po spuštění! (Potlačí defaultní hodnoty)
	_load_settings()
	
	print("[INFO/MAIN_MENU] Playing music")
	# Aplikujeme hlasitost IHNED po načtení
	_apply_audio_settings() 
	audio_stream_player.play()
	
	# 2. Aplikovat načtené hodnoty na UI prvky
	# VSYNC by se mělo nastavit co nejdříve
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	mode_button_video.selected = mode_video
	
	# OPRAVA: Použití call_deferred pro bezpečné nastavení HSlider po plné inicializaci uzlu
	call_deferred("set_slider_value")
	
	# 3. Zobrazení/Skrytí panelů a tlačítek
	settings_panel.hide()
	video_settings_panel.hide()
	play_button.show()
	settings_button.show()
	advancements_button.show()
	exit_button.show()
	music_panel.hide()

# OPRAVA: Nová funkce pro bezpečné nastavení HSlider po inicializaci
func set_slider_value() -> void:
	volume_slider_master.value = volume_music
	print(tr("[DEBUG/MAIN_MENU] HSlider value set to: ") + str(volume_music))

# Zpracování klávesnice pro stisk ESC (Konec hry)
func _input(event):
	if Input.is_action_just_pressed("esc"):
		print("[DEBUG/MAIN_MENU] Pressed Escape button")
		print("[INFO/MAIN_MENU] Exiting the game")
		get_tree().quit()


# ========================================================================
# --- FUNKCE PRO UKLÁDÁNÍ, NAČÍTÁNÍ A APLIKACI NASTAVENÍ ---
# ========================================================================

func _save_settings() -> void:
	# Otevře soubor pro ZÁPIS. Režim WRITE soubor vytvoří nebo vymaže.
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	if file:
		# Získat aktuální vybrané hodnoty z UI prvků do třídních proměnných
		mode_video = mode_button_video.get_selected_id()
		volume_music = volume_slider_master.value # ZÍSKÁNÍ AKTUÁLNÍ HODNOTY SLIDERU
		
		# Uložit proměnné JEDNU PO DRUHÉ (musí se číst v tomto pořadí)
		# POZOR NA POŘADÍ UKLÁDÁNÍ!
		file.store_var(mode_video)
		file.store_var(volume_music) # Ukládáme novou proměnnou
		
		# ZAVŘÍT SOUBOR! Kritické pro zapsání na disk.
		file.close()
		print(tr("[INFO/SAVE] Settings saved. Mode: ") + str(mode_video) + tr(", Music Vol: ") + str(volume_music))
	else:
		print(tr("[ERROR/SAVE] Failed to save settings to: ") + SAVE_PATH)

func _load_settings() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		
		if file:
			# Načíst proměnné ve stejném pořadí, v jakém byly uloženy
			# Pokud selže get_var(), vrátí "null", což způsobí chybu. Použijeme try_catch
			
			var loaded_mode = file.get_var()
			if loaded_mode != null:
				mode_video = loaded_mode
			else:
				print(tr("[ERROR/LOAD] Failed to decode mode_video. Using default."))
				
			# Kontrola, zda existuje další proměnná (pro zpětnou kompatibilitu)
			if not file.eof_reached():
				var loaded_volume = file.get_var()
				if loaded_volume != null:
					volume_music = loaded_volume
				else:
					print(tr("[ERROR/LOAD] Failed to decode volume_music. Using default."))
			
			file.close()
			
			print(tr("[DEBUG/LOAD] Loaded Mode ID: ") + str(mode_video))
			print(tr("[DEBUG/LOAD] Loaded Music Volume: ") + str(volume_music))
		else:
			print(tr("[ERROR/LOAD] Failed to open settings file for reading."))
	else:
		print(tr("[INFO/LOAD] No saved data found. Using default settings."))
		# Ponecháme defaultní hodnoty

func _apply_audio_settings() -> void:
	# FUNKCE PRO APLIKACI HLASITOSTI
	if MUSIC_BUS_INDEX != -1:
		# Převod 0-100 na lineární 0.0-1.0
		var linear_volume = volume_music / 100.0
		
		# Převod lineární hodnoty na decibely (logaritmická škála)
		var db_volume = linear_to_db(linear_volume)
		
		AudioServer.set_bus_volume_db(MUSIC_BUS_INDEX, db_volume)
		print(tr("[INFO/AUDIO] Applied Music Volume: ") + str(volume_music) + tr(" (") + str(db_volume) + " dB)")
	else:
		print(tr("[WARN/AUDIO] Music bus not found! Check AudioBusLayout."))

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

# --- Nastavení Hudby ---

func _on_volume_slider_music_value_changed(value: float) -> void:
	# OKAMŽITÁ APLIKACE HLASITOSTI PŘI POHYBU SLIDEREM
	volume_music = value # Aktualizujeme třídní proměnnou
	_apply_audio_settings() # Aplikujeme nové decibely


# --- Hlavní tlačítka menu ---

func _on_play_button_pressed() -> void:
	print("[DEBUG/MAIN_MENU] Pressed Play button")
	# Uložit nastavení před spuštěním hry
	_save_settings() 
	print("[INFO/MAIN_MENU] Starting scene: " + START_SCENE)
	get_tree().change_scene_to_file(START_SCENE)

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
	print("[INFO/MAIN_MENU] Starting scene: " + START_SCENE)
	get_tree().change_scene_to_file(START_SCENE)

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

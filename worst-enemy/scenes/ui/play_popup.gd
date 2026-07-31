extends Control

signal new_game_pressed
signal continue_pressed

@onready var new_game_button = $Frame/VBoxContainer/NewGameButton
@onready var continue_button = $Frame/VBoxContainer/ContinueButton

func _ready() -> void:
	hide() # Sembunyikan pop-up saat awal game berjalan
	
	# Hubungkan tombol internal ke signal
	if new_game_button:
		new_game_button.pressed.connect(func(): new_game_pressed.emit())
	if continue_button:
		continue_button.pressed.connect(func(): continue_pressed.emit())

# Fungsi untuk membuka pop-up (dipanggil dari main_screen)
func open_popup() -> void:
	show()

# Menutup pop-up saat mengklik area luar (Background)
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		hide()

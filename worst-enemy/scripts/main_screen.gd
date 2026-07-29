extends Control
@onready var play_button: TextureButton = $VBoxContainer/PlayButton
@onready var play_popup: Control = $PlayPopUp
func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	play_popup.new_game_pressed.connect(_on_start_new_game)
	play_popup.continue_pressed.connect(_on_continue_game)
func _on_play_button_pressed() -> void:
	play_popup.open_popup()
func _on_start_new_game() -> void:
	print("Memulai Game Baru...")
	get_tree().change_scene_to_file("res://scenes/loading_screen.tscn") # Sesuaikan path scene Anda
func _on_continue_game() -> void:
	print("Melanjutkan Game...")

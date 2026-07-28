extends Control

func _on_play_button_pressed() -> void:
	# Mengubah scene ke Loading Screen
	get_tree().change_scene_to_file("res://scenes/ui/loading_screen.tscn")

func _on_exit_button_pressed() -> void:
	# Keluar dari aplikasi
	get_tree().quit()

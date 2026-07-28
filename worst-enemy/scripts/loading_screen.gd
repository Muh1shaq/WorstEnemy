extends Control

var target_scene: String = "res://scenes/ui/main_screen.tscn"

func _ready() -> void:
	await get_tree().create_timer(3.0).timeout
	
	if ResourceLoader.exists(target_scene):
		get_tree().change_scene_to_file(target_scene)
	else:
		print("Error: Main Screen tidak ditemukan di ", target_scene)

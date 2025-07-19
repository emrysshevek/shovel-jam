extends Control
class_name Title

func _ready() -> void:
	MusicManager.crossfade_to(load("res://Assets/Audio/Music/main_menu.wav"))

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/overworld.tscn")


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/overworld.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit(0)

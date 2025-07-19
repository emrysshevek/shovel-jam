extends Control

func _ready() -> void:
	MusicManager.play_music(load("res://Assets/Audio/Music/main_menu.wav"))

func _on_quit_button_pressed() -> void:
	get_tree().quit(0)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Hub/overworld.tscn")

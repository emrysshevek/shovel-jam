extends Control
class_name Title


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/overworld.tscn")


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/overworld.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit(0)

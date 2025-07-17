extends Control
class_name Title

@onready var menu_select := $MenuSelectSfx

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/overworld.tscn")

func _on_start_mouse_entered():
	menu_select.play()
extends Control

func _ready() -> void:
	var tween = create_tween().set_loops()
	tween.tween_callback($StartLabel.set_deferred.bind("self_modulate", Color(1,1,1,0))).set_delay(.4)
	tween.tween_callback($StartLabel.set_deferred.bind("self_modulate", Color.WHITE)).set_delay(.4)

func _on_quit_button_pressed() -> void:
	get_tree().quit(0)

func _on_start_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/Hub/overworld.tscn")
	pass

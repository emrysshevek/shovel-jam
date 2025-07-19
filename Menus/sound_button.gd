extends Button
class_name SoundButton

func _on_pressed() -> void:
	MusicManager.play_sfx("res://Assets/Audio/SFX/menu_select_sfx.wav")

func _on_mouse_entered() -> void:
	MusicManager.play_sfx("res://Assets/Audio/SFX/blipSelect.wav")

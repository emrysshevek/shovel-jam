extends Control


@export var sfx_max = -10.0
@export var music_max = 0.0
@export var master_max = 0.0
@export var sound_min = -30.0
@export var songs: Array[AudioStream]

@onready var menu: MenuButton = $Info/AudioSection/Song/SongChoice

func _ready() -> void:
	menu.get_popup().id_pressed.connect(set_song)

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_close_button_pressed() -> void:
	MusicManager.play_sfx("res://Assets/Audio/SFX/pause game.wav")
	hide()
	get_tree().paused = false



func _on_music_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index(&"Music")
	if value == 0.0:
		AudioServer.set_bus_mute(bus_idx, true)
		return
	elif AudioServer.is_bus_mute(bus_idx):
		AudioServer.set_bus_mute(bus_idx, false)	
		
	value = value / 100.0
	var volume = (value * music_max) + ((1-value) * sound_min)
	AudioServer.set_bus_volume_db(bus_idx, volume)


func _on_sfx_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index(&"SFX")
	if value == 0.0:
		AudioServer.set_bus_mute(bus_idx, true)
		return
	elif AudioServer.is_bus_mute(bus_idx):
		AudioServer.set_bus_mute(bus_idx, false)	
		
	value = value / 100.0
	var volume = (value * sfx_max) + ((1-value) * sound_min)
	AudioServer.set_bus_volume_db(bus_idx, volume)


func _on_master_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index(&"Master")
	if value == 0.0:
		AudioServer.set_bus_mute(bus_idx, true)
		return
	elif AudioServer.is_bus_mute(bus_idx):
		AudioServer.set_bus_mute(bus_idx, false)	
		
	value = value / 100.0
	var volume = (value * master_max) + ((1-value) * sound_min)
	AudioServer.set_bus_volume_db(bus_idx, volume)


func _on_damage_box_toggled(toggled_on: bool) -> void:
	Globals.damage_enabled = toggled_on

func set_song(id) -> void:
	MusicManager.crossfade_to(songs[id])
	match id:
		0:
			menu.text = "Whimsical Forest"
		1:
			menu.text = "Volcanic Ash"
		2:
			menu.text = "Hall of Illusions"

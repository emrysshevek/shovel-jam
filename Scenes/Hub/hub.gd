extends Node2D
class_name Hub

@export var music: AudioStream

func _ready() -> void:
	MusicManager.play_music(music)

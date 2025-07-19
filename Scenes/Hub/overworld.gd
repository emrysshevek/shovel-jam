extends Node2D

@export var music: AudioStream

func _ready() -> void:
	MusicManager.crossfade_to(music)

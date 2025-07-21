extends Node

@export var max_sounds := 16
@export var sfx_files: Array[AudioStream] = []

# References to the nodes in our scene
@onready var _track_1: AudioStreamPlayer = $Track1
@onready var _track_2: AudioStreamPlayer = $Track2

var sfx_tracks = {}
var sfx_pool: Array[AudioStreamPlayer] = []
var used: Array[AudioStreamPlayer] = []
var available: Array[AudioStreamPlayer] = []

func _ready() -> void:
	for i in range(max_sounds):
		var player := AudioStreamPlayer.new()
		player.bus = "SFX"
		$SFXPlayers.add_child(player)
		player.finished.connect(func(): _on_sfx_finished(player))
		sfx_pool.append(player)
		available.append(player)
	
	for stream: AudioStream in sfx_files:
		sfx_tracks[stream.resource_path] = stream

# crossfades to a new audio stream
func crossfade_to(audio_stream: AudioStream, fade_duration:=.5) -> void:
	print("Changing background music to ", str(audio_stream.resource_path))
	if not _track_1.playing:
		_track_1.stream = audio_stream
		_track_1.play()
		return
	elif _track_1.stream == audio_stream:
		return
	
	var tween = create_tween()
	tween.tween_property(_track_1, ^"volume_db", -80.0, fade_duration)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CIRC)
	tween.finished.connect(func(): _on_fade_out_finished(audio_stream))

func _on_fade_out_finished(stream: AudioStream) -> void:
	print("switching to ", stream.resource_path)
	_track_1.stop()
	_track_1.volume_db = 0.0
	_track_1.stream = stream
	_track_1.play()

func play_music(audio_stream: AudioStream):
	_track_1.stop()
	_track_1.volume_db = 0.0
	_track_1.stream = audio_stream
	_track_1.play()

func play_sfx(file: String, pitch=1, volume=0.0) -> AudioStreamPlayer:
	if available.is_empty():
		var player: AudioStreamPlayer = used.pop_front()
		player.stop()
		player.volume_db = 0.0
		player.pitch_scale
		available.append(player)
	
	var stream = sfx_tracks[file]
	var player: AudioStreamPlayer = available.pop_front()
	player.stream = stream
	player.pitch_scale = pitch
	player.volume_db = volume
	player.play()
	used.append(player)
	
	return player
		
func _on_sfx_finished(player: AudioStreamPlayer) -> void:
	used.erase(player)
	available.append(player)
	

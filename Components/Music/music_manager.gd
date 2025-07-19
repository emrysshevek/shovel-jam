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
	# If both tracks are playing, we're calling the function in the middle of a fade.
	# We return early to avoid jumps in the sound.
	#if _track_1.playing and _track_2.playing:
		#return
	
	# The `playing` property of the stream players tells us which track is active. 
	# If it's track two, we fade to track one, and vice-versa.
	#var starting_track := _track_1
	#var target_track := _track_2
	#
	#if _track_2.playing:
		#starting_track = _track_2
		#target_track = _track_1
		#
	#target_track.volume_db = -80.0
	#target_track.stream = audio_stream
	#target_track.play()
		#
	#var tween = create_tween().set_parallel(true)
	#tween.set_ease(Tween.EASE_IN_OUT)
	#tween.set_trans(Tween.TRANS_CIRC)
	#
	#tween.tween_property(starting_track, ^"volume_db", -80.0, fade_duration)
	#tween.tween_callback()
	#tween.tween_property(target_track, ^"volume_db", 0.0, fade_duration)
	
	#tween.finished.connect(func(): starting_track.stop())
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

func play_sfx(file: String, pitch=1, volume=0.0):
	if available.is_empty():
		var player: AudioStreamPlayer = used.pop_front()
		player.stop()
		player.volume_db = 0.0
		player.pitch_scale
		available.append(player)
	
	var stream = sfx_tracks[file]
	var player = available.pop_front()
	player.stream = stream
	player.pitch_scale = pitch
	player.volume_db = volume
	player.play()
	used.append(player)
		
func _on_sfx_finished(player: AudioStreamPlayer) -> void:
	used.erase(player)
	available.append(player)
	

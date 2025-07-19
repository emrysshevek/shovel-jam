extends Node

# References to the nodes in our scene
@onready var _track_1: AudioStreamPlayer = $Track1
@onready var _track_2: AudioStreamPlayer = $Track2

# crossfades to a new audio stream
func crossfade_to(audio_stream: AudioStream, fade_duration:=.5) -> void:
	print("Changing background music to ", str(audio_stream))
	# If both tracks are playing, we're calling the function in the middle of a fade.
	# We return early to avoid jumps in the sound.
	if _track_1.playing and _track_2.playing:
		return

	# The `playing` property of the stream players tells us which track is active. 
	# If it's track two, we fade to track one, and vice-versa.
	var starting_track := _track_1
	var target_track := _track_2
	
	if _track_2.playing:
		starting_track = _track_2
		target_track = _track_1
		
	target_track.volume_db = -80.0
	target_track.stream = audio_stream
	target_track.play()
		
	var tween = create_tween().set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CIRC)
	
	tween.tween_property(starting_track, ^"volume_db", -80.0, fade_duration)
	tween.tween_property(target_track, ^"volume_db", 0.0, fade_duration)
	
	tween.finished.connect(func(): starting_track.stop())	

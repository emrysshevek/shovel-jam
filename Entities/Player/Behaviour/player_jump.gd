class_name PlayerJumpState
extends PlayerState

var jump_duration: float
var in_jump: bool = false
var elapsed := 0.0
var holding = true

func enter(_previous_state_path: String, _data := {}) -> void:
	MusicManager.play_sfx("res://Assets/Audio/SFX/jump.wav")
	player.jump.emit()
	player.velocity.y = -player.jump_velocity
	if Input.is_action_pressed(&"run"):
		player.velocity.y *= 1.2
	in_jump = true
	elapsed = 0
	holding = Input.is_action_pressed(&"jump")

func exit() -> void:
	in_jump = false

func physics_update(delta: float) -> void:
	finished.emit(FLOAT)

class_name PlayerWalkState
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.ap.play("Walk")
	player.step.connect(_on_sprite_step)
	
func exit() -> void:
	player.ap.stop()
	player.ap.speed_scale = 1
	player.step.disconnect(_on_sprite_step)

func physics_update(delta: float) -> void:
	
	if not player.is_on_floor():
		finished.emit(FLOAT)
		return
	if Input.is_action_just_pressed(&"jump"):
		finished.emit(JUMP)
		return
	elif not Input.is_action_pressed(&"move_left") and not Input.is_action_pressed(&"move_right"):
		finished.emit(IDLE)
		return
		
	var dir = Input.get_axis(&"move_left", &"move_right")
	var speed = player.max_speed
	if Input.is_action_pressed(&"run"):
		speed *= 2
	player.velocity.x = move_toward(player.velocity.x, speed * dir, player.ground_acceleration * delta)
	player.ap.speed_scale = abs(player.velocity.x) / player.walk_animation_default_speed

func _on_sprite_step() -> void:
	var scale = abs(player.velocity.x) / player.max_speed
	var pitch = clamp(scale, .9, 1.1)
	pitch = randf_range(pitch * .9, pitch * 1.1)
	var volume = randf_range(-3, 1)
	MusicManager.play_sfx("res://Assets/Audio/SFX/click.wav", pitch, volume)

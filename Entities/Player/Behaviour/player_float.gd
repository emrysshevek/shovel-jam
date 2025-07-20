class_name PlayerFloatState
extends PlayerState

@export var fall_speed_influence = .5

var speed := 0.0

func enter(_previous_state_path: String, _data := {}) -> void:
	if _previous_state_path != JUMP:
		player.velocity.y = 0
	player.ap.play("Idle_2")
	speed = max(abs(player.velocity.x), player.max_speed)

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		finished.emit(IDLE)
		return
		
	if Input.is_action_just_pressed(&"jump") and player.is_on_wall_only():
		finished.emit(WALLJUMP)
		return
		
	var dir = Input.get_axis(&"move_left", &"move_right")
	if dir != 0:
		player.velocity.x = move_toward(player.velocity.x, speed * dir, player.air_acceleration * delta)

	if Input.is_action_pressed("jump"):
		player.gravity.set_gravity(player.gravity.default * .7)
	elif Input.is_action_pressed("crouch"):
		player.gravity.set_gravity(player.gravity.default * 1.3)
	else:
		player.gravity.reset_gravity()

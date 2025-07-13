class_name PlayerFloatState
extends PlayerState

@export var fall_speed_influence = .5

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		finished.emit(IDLE)
		return
		
	var dir = Input.get_axis(&"move_left", &"move_right")
	if dir == 0:
		player.velocity.x = move_toward(player.velocity.x, 0, player.air_friction * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, player.max_speed * dir, player.air_acceleration * delta)
		
	if Input.is_action_pressed("jump"):
		player.gravity.set_gravity(player.gravity.default * .7)
	elif Input.is_action_pressed("crouch"):
		player.gravity.set_gravity(player.gravity.default * 1.3)
	else:
		player.gravity.reset_gravity()

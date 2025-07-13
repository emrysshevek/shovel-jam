class_name PlayerWalkState
extends PlayerState
	

func physics_update(delta: float) -> void:
	
	if Input.is_action_just_pressed(&"jump"):
		finished.emit(JUMP)
		return
	elif not Input.is_action_pressed(&"move_left") and not Input.is_action_pressed(&"move_right"):
		finished.emit(IDLE)
		return
		
	#if not player.is_on_floor():
		#return
	
	var dir = Input.get_axis(&"move_left", &"move_right")
	var speed = player.max_speed
	if Input.is_action_pressed(&"run"):
		speed *= 2
	player.velocity.x = move_toward(player.velocity.x, speed * dir, player.ground_acceleration * delta)

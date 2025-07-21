class_name PlayerIdleState
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.ap.play("Idle_1")
	
func physics_update(delta: float) -> void:
	if player.velocity != Vector2.ZERO:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, player.ground_friction * delta)
		
	if not player.is_on_floor():
		finished.emit(FLOAT)
		return
	elif Input.is_action_just_pressed(&"jump"):
		finished.emit(JUMP)
		return
	elif Input.is_action_pressed(&"move_left") or Input.is_action_pressed(&"move_right"):
		finished.emit(WALK)
		return

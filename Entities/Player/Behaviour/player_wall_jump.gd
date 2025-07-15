extends PlayerState
class_name PlayerWallJumpState


func enter(_previous_state_path: String, _data := {}) -> void:
	if not player.is_on_wall_only():
		printerr("ATTEMPING TO WALL JUMP IMPROPERLY")
		finished.emit(_previous_state_path)
		return
	
func physics_update(_delta: float) -> void:
	var dir = sign(player.get_last_slide_collision().get_normal().x)
	player.velocity = Vector2(dir, -1).normalized() * player.jump_velocity
	
	finished.emit(FLOAT)
	return

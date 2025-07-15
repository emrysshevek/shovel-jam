extends PlayerState
class_name PlayerSwimState

@export var duration := 1.0
@export var speed := 500.0
@export var rotation_speed := 2 * PI * 4

func enter(_previous_state_path: String, _data := {}) -> void:
	if player.floating_collision.disabled:
		player.floating_collision.set_deferred("disabled", false)
		player.default_collision.set_deferred("disabled", true)

func physics_update(delta) -> void:
	if Input.is_action_pressed(&"run"):
		player.velocity = player.velocity.move_toward(Vector2.UP.rotated(player.rotation) * speed, player.max_speed * delta)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, player.air_friction * delta)
		
	var dir = Input.get_vector(&"left", &"right", &"up", &"down")
	if dir != Vector2.ZERO:
		var target = Vector2.UP.angle_to(dir)
		player.rotation = target
	

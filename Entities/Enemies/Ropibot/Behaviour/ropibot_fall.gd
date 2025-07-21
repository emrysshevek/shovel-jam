extends RopibotState
class_name RopibotFall

var stuck_the_landing = true

@onready var player: Player = get_tree().get_first_node_in_group("player")

func enter(_previous_state_path: String, _data := {}) -> void:
	var tween = create_tween()
	var angle = ropibot.gravity.direction.angle_to(Vector2.DOWN)
	if abs(rad_to_deg(angle)) > 45:
		stuck_the_landing = false
		tween.tween_property(ropibot, ^"rotation", PI, .25)
	else:
		stuck_the_landing = true
		tween.tween_property(ropibot, ^"rotation", 0, .25)
		
	ropibot.gravity.direction = Vector2.DOWN
	ropibot.gravity.reset_gravity()
	
	ropibot.ap.play("Land")
	
func physics_update(delta: float) -> void:
	for i in ropibot.get_slide_collision_count():
		var collision = ropibot.get_slide_collision(i)
		print(collision.get_normal())
		if collision.get_normal().dot(Vector2.UP) > .95:
			_on_landed()
		return
				
func _on_landed() -> void:
	MusicManager.play_sfx("res://Assets/Audio/SFX/robot landing.wav")
	if stuck_the_landing:
		if ropibot.global_position.distance_to(player.global_position) <= ropibot.outer_vision_range.shape.radius:
			finished.emit(PURSUE)
		else:
			finished.emit(IDLE)
	else:
		finished.emit(SPRING)

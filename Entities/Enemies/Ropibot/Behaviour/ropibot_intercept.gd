extends RopibotState
class_name RopibotIntercept

@onready var player: Player = get_tree().get_first_node_in_group("player")

func enter(_previous_state_path: String, _data := {}) -> void:
	ropibot.ap.play("Jumping")
	ropibot.ap.animation_finished.connect(_on_animation_finished)
	ropibot.velocity = Vector2.ZERO
	
func exit() -> void:
	ropibot.ap.animation_finished.disconnect(_on_animation_finished)
	
func _on_animation_finished(name: StringName) -> void:
	print(name)
	if name == "Jumping":
		ropibot.velocity = -ropibot.transform.y * ropibot.jump_velocity
		finished.emit(FALL)
	else:
		finished.emit(IDLE)

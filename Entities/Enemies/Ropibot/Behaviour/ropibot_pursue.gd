extends RopibotState
class_name RopibotPursue

@onready var player: Player = get_tree().get_first_node_in_group("player")

func enter(_previous_state_path: String, _data := {}) -> void:
	ropibot.inner_vision_range.set_deferred("disabled", true)
	ropibot.outer_vision_range.set_deferred("disabled", false)
	ropibot.player_lost.connect(_on_player_lost)
	player.jump.connect(_on_player_jump)

func physics_update(delta: float) -> void:
	var dir = sign(ropibot.global_position.direction_to(player.global_position).x)
	var dist = abs((player.global_position - ropibot.global_position).dot(ropibot.transform.x))
	if dist > 25:
		ropibot.move(delta, dir, ropibot.max_speed)

func exit() -> void:
	ropibot.player_lost.disconnect(_on_player_lost)
	player.jump.disconnect(_on_player_jump)
	ropibot.inner_vision_range.set_deferred("disabled", false)
	ropibot.outer_vision_range.set_deferred("disabled", true)

func _on_player_lost() -> void:
	finished.emit(IDLE)
	
func _on_player_jump() -> void:
	finished.emit(INTERCEPT)

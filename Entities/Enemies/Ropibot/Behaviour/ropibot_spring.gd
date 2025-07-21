extends RopibotState
class_name RopibotSpring

func enter(_previous_state_path: String, _data := {}) -> void:
	ropibot.active = false
	ropibot.platform.queue_free()
	ropibot.player_overlapped.connect(spring_player)
	ropibot.ap.speed_scale = 3
	
func spring_player() -> void:
	MusicManager.play_sfx("res://Assets/Audio/SFX/robot spring.wav")
	var player: Player = get_tree().get_first_node_in_group(&"player")
	player.velocity.y = -10000
	ropibot.ap.play("Launch")
	ropibot.ap.queue("Retract")

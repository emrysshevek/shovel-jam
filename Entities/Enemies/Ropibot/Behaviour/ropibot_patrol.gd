extends RopibotState
class_name RopibotPatrol

@onready var timer: Timer = Timer.new()

var dir_counts = { -1: 1.0, 1: 1.0}
var direction = 0

func _ready() -> void:
	super._ready()
	timer.wait_time = 5
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(finished.emit.bind(IDLE))
	add_child(timer)

func enter(_previous_state_path: String, _data := {}) -> void:
	ropibot.player_spotted.connect(_on_player_spotted)
	ropibot.ap.play("Rolling")
	var probability = 1.0 - (dir_counts[1] / (dir_counts[-1] + dir_counts[1]))
	direction = 1 if randf() < probability else -1
	dir_counts[direction] += 1
	timer.start()
	
func physics_update(delta: float) -> void:
	ropibot.move(delta, direction, ropibot.max_speed)
	
func exit() -> void:
	timer.stop()
	ropibot.player_spotted.disconnect(_on_player_spotted)
	
func _on_player_spotted() -> void:
	finished.emit(PURSUE)

extends EntityState
class_name RopibotPatrol

@onready var timer: Timer = Timer.new()

var dir_counts = { -1: 1.0, 1: 1.0}

func _ready() -> void:
	super._ready()
	timer.wait_time = 5
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(finished.emit.bind(IDLE))
	add_child(timer)

func enter(_previous_state_path: String, _data := {}) -> void:
	entity.ap.play("Rolling")
	var probability = 1.0 - (dir_counts[1] / (dir_counts[-1] + dir_counts[1]))
	var dir = 1 if randf() < probability else -1
	dir_counts[dir] += 1
	entity.velocity.x = dir * entity.max_speed
	timer.start()
	
func exit() -> void:
	timer.stop()

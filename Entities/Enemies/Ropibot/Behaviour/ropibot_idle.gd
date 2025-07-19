extends EntityState
class_name RopibotIdle

@onready var timer:Timer = Timer.new()

func _ready() -> void:
	super._ready()
	timer.wait_time = 2.0
	timer.autostart = true
	timer.one_shot = true
	timer.timeout.connect(finished.emit.bind("Patrol"))
	add_child(timer)

func enter(_previous_state_path: String, _data := {}) -> void:
	entity.velocity = Vector2.ZERO
	entity.ap.play("Bite")
	timer.wait_time = 2.0
	timer.start()

extends RopibotState
class_name RopibotIdle

@onready var timer:Timer = Timer.new()

func _ready() -> void:
	super._ready()
	timer.wait_time = 2.0
	timer.autostart = true
	timer.one_shot = true
	timer.timeout.connect(finished.emit.bind(PATROL))
	add_child(timer)

func enter(_previous_state_path: String, _data := {}) -> void:
	ropibot.player_spotted.connect(_on_player_spotted)
	ropibot.velocity = Vector2.ZERO
	ropibot.ap.play("Bite")
	timer.wait_time = 2.0
	timer.start()
	
func exit() -> void:
	timer.stop()
	ropibot.player_spotted.disconnect(_on_player_spotted)
	
func _on_player_spotted() -> void:
	finished.emit(PURSUE)

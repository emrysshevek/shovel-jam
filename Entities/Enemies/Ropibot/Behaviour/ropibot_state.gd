extends State
class_name RopibotState

const IDLE := "Idle"
const PATROL := "Patrol"
const PURSUE := "Pursue"
const INTERCEPT := "Intercept"
const FALL := "Fall"
const SPRING := "Spring"

var ropibot: Ropibot

func _ready() -> void:
	await owner.ready
	ropibot = owner
	assert(ropibot != null, "Ropibot state must be used in Ropibot node")

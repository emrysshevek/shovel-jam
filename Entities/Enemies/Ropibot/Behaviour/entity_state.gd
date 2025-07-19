extends State
class_name EntityState

const IDLE := "Idle"
const PATROL := "Patrol"
const PURSUE := "Pursue"
const INTERCEPT := "Intercept"
const SPRING := "Spring"

var entity: Entity

func _ready() -> void:
	await owner.ready
	entity = owner
	assert(entity != null, "Entity state must be used in Entity node")

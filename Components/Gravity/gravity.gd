extends Node2D
class_name Gravity

@export var default := 2000.0
@export var direction := Vector2.DOWN
@export var enabled := true

var entity: Entity

@onready var gravity := default

func _ready() -> void:
	await owner.ready
	entity = owner
	assert(entity != null, "Gravity must be used inside Physics node")
	
	direction = direction.normalized()

func _physics_process(delta: float) -> void:
	if enabled:
		entity.velocity = entity.velocity.move_toward(direction * entity.max_fall_speed, gravity * delta)

func set_gravity(val: float) -> void:
	gravity = val

func reset_gravity() -> void:
	gravity = default
	
func set_direction(dir: Vector2) -> void:
	direction = dir.normalized()

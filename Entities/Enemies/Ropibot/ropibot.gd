extends Entity
class_name Ropibot

signal player_spotted()
signal player_lost()
signal player_overlapped()

var active = true

@onready var inner_vision_range: CollisionShape2D = $VisionRange/InnerRange
@onready var outer_vision_range: CollisionShape2D = $VisionRange/OuterRange
@onready var platform: AnimatableBody2D = $Platform

var contacts = []

func _ready() -> void:
	super._ready()
	gravity.set_deferred("default", Globals.gravity)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	#print(velocity)
	
func move(delta: float, dir: int, speed: float) -> void:	
	var count = get_slide_collision_count()
	var down = transform.y
	#print("contact count: ", count)
	if count == 0:
		return
	elif count == 1:
		var contact_pos = get_last_slide_collision().get_position()
		down = global_position.direction_to(contact_pos)
	else:
		var mean_position := Vector2.ZERO
		for i in range(count):
			var collision := get_slide_collision(i)
			mean_position += collision.get_position()
		mean_position /= count
		down = global_position.direction_to(mean_position)
		
	#gravity.set_direction(gravity.direction.move_toward(down, delta * 2 * PI))
	gravity.direction = down
	rotation = Vector2.DOWN.angle_to(gravity.direction)
	$ForwardRay.target_position = gravity.direction.normalized() * 3000
	
	var grav_component = 10 * gravity.direction
	var move_component = dir * gravity.direction.orthogonal() * speed
	#print("Gravity: ", grav_component, ", movement: ", move_component)
	velocity = grav_component + move_component
	
func flip() -> void:
	super.flip()

func _on_vision_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_spotted.emit()


func _on_vision_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_lost.emit()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if active:
			body.take_damage(1)
		player_overlapped.emit()

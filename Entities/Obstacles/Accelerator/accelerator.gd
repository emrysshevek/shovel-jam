extends Node2D
enum Acceleration_Direction {UP, UP_RIGHT, RIGHT, DOWN_RIGHT, DOWN, DOWN_LEFT, LEFT, UP_LEFT}

@export var acceleration_amount := 500.0
@export_enum("UP", "UP_RIGHT", "RIGHT", "DOWN_RIGHT", "DOWN", "DOWN_LEFT", "LEFT", "UP_LEFT") var acceleration_direction : int = Acceleration_Direction.UP
@onready var arrow := $Arrow

func _ready():
	check_arrow_direction()

func _on_hitbox_entered(body:Node2D):
	if body is Player:
		print("Accelerating player")
		match acceleration_direction:
			Acceleration_Direction.UP:
				body.velocity.y = -acceleration_amount
			Acceleration_Direction.DOWN:
				body.velocity.y = acceleration_amount
			Acceleration_Direction.LEFT:
				body.velocity.x = -acceleration_amount
			Acceleration_Direction.RIGHT:
				body.velocity.x = acceleration_amount
			Acceleration_Direction.UP_LEFT:
				body.velocity.x = -acceleration_amount
				body.velocity.y = -acceleration_amount
			Acceleration_Direction.UP_RIGHT:
				body.velocity.x = acceleration_amount
				body.velocity.y = -acceleration_amount
			Acceleration_Direction.DOWN_LEFT:
				body.velocity.x = -acceleration_amount
				body.velocity.y = acceleration_amount
			Acceleration_Direction.DOWN_RIGHT:
				body.velocity.x = acceleration_amount
				body.velocity.y = acceleration_amount

func check_arrow_direction():
		arrow.rotation_degrees = acceleration_direction * 45

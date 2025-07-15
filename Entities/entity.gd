extends CharacterBody2D
class_name Entity

@export var max_speed := 300.0
@export var ground_acceleration := 1000.0
@export var ground_friction := 1000.0

@export var jump_velocity := 500.0
@export var max_fall_speed := 1000.0
@export var air_acceleration := 800.0
@export var air_friction := 200.0

@onready var gravity := find_children("*", "Gravity")[0]

func _physics_process(delta: float) -> void:
	move_and_slide()

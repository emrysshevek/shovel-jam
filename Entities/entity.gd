extends CharacterBody2D
class_name Entity

@export var current_hearts := 3
@export var max_hearts := 3
@export var max_speed := 300.0
@export var ground_acceleration := 1000.0
@export var ground_friction := 1000.0

@export var jump_velocity := 500.0
@export var max_fall_speed := 1000.0
@export var air_acceleration := 800.0
@export var air_friction := 200.0

var flipped = false
var velocity_buffer = Vector2.ZERO

@onready var gravity: Gravity = find_children("*", "Gravity")[0]
@onready var sprite: Node2D = $Sprite
@onready var ap: AnimationPlayer = $Sprite/AnimationPlayer

func _ready():
	#current_hearts = max_hearts
	pass
	
func flip() -> void:
	sprite.transform *= Transform2D.FLIP_X;
	flipped = !flipped

func _physics_process(delta: float) -> void:
	_check_flip()
	move_and_slide()
	
func _check_flip() -> void:
	var dir = sign(velocity.x)
	if (dir == -1 and not flipped) or (dir == 1 and flipped):
		flip()

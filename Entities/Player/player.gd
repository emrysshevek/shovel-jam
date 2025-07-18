class_name Player
extends Entity

@export var jump_height := 4000.0
@export var jump_duration := .75

@onready var default_collision: CollisionShape2D = $DefaultCollision
@onready var floating_collision: CollisionShape2D = $FloatingCollision
@onready var ap: AnimationPlayer = $PlayerSprite/AnimationPlayer

func _ready() -> void:
	# h = v^2 / 2g
	# => g = (1/2h) * v^2
	#
	# t = 2v / g
	# => t = 2v / (v^2/2h)
	# => t = 4hv/v^2
	# => t = 4h/v
	# 
	# v = 4h/t
	# g = 2v/t
	
	jump_velocity = 4 * jump_height / jump_duration
	max_fall_speed = jump_velocity
	gravity.default = 2 * jump_velocity / jump_duration
	

func take_damage(amount: int):
	current_hearts -= amount
	print("The player took %d damage!" %[amount])
	print("Current Health: %d" % current_hearts)

func _process(_delta):
	if Input.is_action_just_pressed("accel"):
		velocity.y -= 500
		print("accel")

class_name Player
extends Entity

signal step()

@export var jump_height := 4000.0
@export var jump_duration := .75
@export var walk_animation_default_speed = 700

@onready var default_collision: CollisionPolygon2D = $DefaultCollision
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
	MusicManager.play_sfx("res://Assets/Audio/SFX/hitHurt.wav")
	current_hearts -= amount
	print("The player took %d damage!" %[amount])
	print("Current Health: %d" % current_hearts)
	if current_hearts <= 0:
		MusicManager.play_sfx("res://Assets/Audio/SFX/crash_restart_level_sfx.wav")
		get_tree().change_scene_to_file("res://Scenes/Hub/overworld.tscn")
		
func _process(_delta):
	if Input.is_action_just_pressed("accel"):
		velocity.y -= 500
		print("accel")

func _on_player_sprite_step() -> void:
	step.emit()

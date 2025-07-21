class_name Player
extends Entity

signal step()
signal jump()

@export var jump_height := 4000.0
@export var jump_duration := .75
@export var walk_animation_default_speed = 700

var invincible := false

@onready var default_collision: CollisionShape2D = $DefaultCollision
@onready var floating_collision: CollisionShape2D = $FloatingCollision

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
	max_fall_speed = jump_velocity * 2
	gravity.default = 2 * jump_velocity / jump_duration
	Globals.gravity = gravity.default
	
func take_damage(amount: int):
	if not Globals.damage_enabled or invincible:
		return
	MusicManager.play_sfx("res://Assets/Audio/SFX/taking damage.wav")
	current_hearts -= amount
	print("The player took %d damage!" %[amount])
	print("Current Health: %d" % current_hearts)
	if current_hearts <= 0:
		MusicManager.play_sfx("res://Assets/Audio/SFX/crash-restart level sfx version 2.wav")
		get_tree().change_scene_to_file.call_deferred("res://Scenes/Hub/overworld.tscn")
	else:
		invincible = true
		var tween = create_tween().set_loops(10)
		tween.tween_callback(set_deferred.bind("modulate", Color(1,1,1,0))).set_delay(.1)
		tween.tween_callback(set_deferred.bind("modulate", Color.WHITE)).set_delay(.1)
		tween.finished.connect(set_deferred.bind("invincible", false))
		
func _process(_delta):
	if Input.is_action_just_pressed("accel"):
		velocity.y -= 500
		print("accel")

func _on_player_sprite_step() -> void:
	step.emit()

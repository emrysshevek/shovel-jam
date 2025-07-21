extends Node2D
class_name Friend

signal freed()

@export var loop_duration := 2.0
@export var float_amplitude := 150.0

var free := false
var offset_buffer := 0.0

@onready var player: Player = get_tree().get_first_node_in_group(&"player")

func _ready() -> void:
	var tween = create_tween().set_loops()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_method(_float, 0.0, float_amplitude, loop_duration / 2.0)
	tween.tween_method(_float, float_amplitude, 0.0, loop_duration / 2.0)
	
	
func _float(val: float) -> void:
	var step = val - offset_buffer
	position.y += step
	offset_buffer = val

func _on_interactable_interaction_occured() -> void:
	print("friend was interacted")
	MusicManager.play_sfx("res://Assets/Audio/SFX/retrieve_friend_sfx.wav")
	free = true
	freed.emit()
	
	var camera = get_tree().get_first_node_in_group(&"camera")
	var portal: Portal = get_tree().get_first_node_in_group(&"portal")
	var camera_pos = camera.global_position
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CIRC)
	tween.tween_property(camera, "global_position", portal.global_position, .5)
	tween.tween_callback(portal._on_friend_freed).set_delay(.5)
	tween.tween_property(camera, "global_position", camera.global_position, .5).set_delay(.5)
	
func _physics_process(delta: float) -> void:
	if not free:
		return
		
	if global_position.distance_to(player.global_position) > 1000:
		print("Lerping friend position")
		global_position = global_position.lerp(player.global_position, delta * 4)
		

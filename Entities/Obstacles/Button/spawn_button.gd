extends Sprite2D
class_name SpawnButton

@export var spawn_scene: PackedScene

var spawned_item: Node2D = null

@onready var marker: Node2D

func _ready() -> void:
	for child in get_children():
		print(child)
	marker = get_child(1)
	var pos = global_position
	var tween = create_tween().set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, ^"global_position", pos + Vector2(0, 100), 1)
	tween.tween_property(self, ^"global_position", pos, 1)

func _on_interactable_interaction_occured() -> void:
	if spawn_scene == null:
		return
		
	if spawned_item != null and is_instance_valid(spawned_item):
		spawned_item.queue_free()
		
	spawned_item = spawn_scene.instantiate()
	spawned_item.global_position = marker.global_position
		
	var camera = get_tree().get_first_node_in_group(&"camera")
	var camera_pos = camera.global_position
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CIRC)
	tween.tween_property(camera, "global_position", marker.global_position, .5)
	tween.tween_callback(add_child.bind(spawned_item)).set_delay(.5)
	tween.tween_property(camera, "global_position", camera.global_position, .5).set_delay(.5)
	
	hide()
	get_tree().create_timer(10).timeout.connect(show)

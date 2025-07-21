extends Area2D
class_name Room

signal player_entered()
signal player_exited()

var entity_scenes: Array[PackedScene]

func _ready() -> void:
	setup_room.call_deferred()
		
func setup_room() -> void:
	for i in range(1, get_child_count()):
		var entity = get_child(i)
		var scene = PackedScene.new()
		scene.pack(entity)
		entity_scenes.append(scene)
		entity.queue_free()
	
		
func _on_body_entered(body: Node2D) -> void:
	print("body entered room")
	if body.is_in_group("player"):
		player_entered.emit()
		load_room()
		
func _on_body_exited(body: Node2D) -> void:
	print("body entered room")
	if body.is_in_group("player"):
		player_exited.emit()
		unload_room()
	
func load_room() -> void:
	for scene: PackedScene in entity_scenes:
		add_child.call_deferred(scene.instantiate())
		
func unload_room() -> void:
	for i in range(1, get_child_count()):
		get_child(i).queue_free()

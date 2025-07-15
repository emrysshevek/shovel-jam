extends Node2D
class_name Friend

signal freed()

var free := false

@onready var player: Player = get_tree().get_first_node_in_group(&"player")

func _on_interactable_interaction_occured() -> void:
	print("friend was interacted")
	free = true
	freed.emit()
	
func _physics_process(delta: float) -> void:
	if not free:
		return
		
	if global_position.distance_to(player.global_position) > 24:
		print("Lerping friend position")
		global_position = global_position.lerp(player.global_position, delta * 4)

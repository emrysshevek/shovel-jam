extends Sprite2D
class_name ToggleButton

@onready var interactive_tilemap: InteractiveTileMap = get_tree().get_first_node_in_group(&"toggle")

func _on_interactable_interaction_occured() -> void:
	interactive_tilemap.toggle()
	

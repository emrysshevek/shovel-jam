extends Area2D
var is_in_interaction_area = false 

@onready var interactable = $Interactable
@export var level_scene: PackedScene

func _process(_delta):
	pass

func _on_interactable_interaction_occured():
	if level_scene != null:
		get_tree().change_scene_to_packed(level_scene)

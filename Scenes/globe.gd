extends Area2D
class_name Globe

@export var level: int
@export var level_scene: PackedScene

var is_in_interaction_area := false
var can_enter := false

@onready var data = Globals.stage_data[level]
@onready var interactable = $Interactable
@onready var label: Label = $Label

func _ready() -> void:
	if data["complete"]:
		label.text = "COMPLETE"
		label.show()
	elif data["unlocked"]:
		label.hide()
		can_enter = true
	else:
		label.text = "LOCKED"
		label.show()

func _on_interactable_interaction_occured():
	if can_enter and level_scene != null:
		get_tree().change_scene_to_packed(level_scene)

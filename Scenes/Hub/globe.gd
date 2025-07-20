extends Node2D
class_name Globe

@export var level: int
@export var level_scene: PackedScene

var is_in_interaction_area := false
var can_enter := false
var active = false

@onready var data = Globals.stage_data[level]
@onready var interactable = $Interactable
@onready var label: Label = $Label
@onready var tween = null

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
	if active and can_enter and level_scene != null:
		get_tree().change_scene_to_packed(level_scene)


func _on_interactable_body_entered(body: Node2D) -> void:
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.tween_property($Base, "self_modulate", Color("00e200"), .25)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)


func _on_interactable_body_exited(body: Node2D) -> void:
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.tween_property($Base, "self_modulate", Color.WHITE, .25)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)

extends Area2D
class_name InteractableArea
var is_in_interaction_area = false 

signal interaction_occured

func _on_interaction_area_entered(body:Node2D):
	if body.is_in_group("player"):
		is_in_interaction_area = true
		print("player entered area")

func _on_interaction_area_exited(body:Node2D):
	if body.is_in_group("player"):
		is_in_interaction_area = false
		print("player exited area")

func interact():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("interact") and is_in_interaction_area == true:
		emit_signal("interaction_occured")

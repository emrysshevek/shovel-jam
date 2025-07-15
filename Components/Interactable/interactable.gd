extends Area2D
class_name InteractableArea

signal interaction_occured

var is_in_interaction_area = false 

func _process(_delta):
	if Input.is_action_just_pressed("interact") and is_in_interaction_area == true:
		interaction_occured.emit()

func interact():
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_in_interaction_area = true
		print("Player entered interaction area")
		
func _on_body_exited(body:Node2D):
	if body.is_in_group("player"):
		is_in_interaction_area = false
		print("player exited interaction area")

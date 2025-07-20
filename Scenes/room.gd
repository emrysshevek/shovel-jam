extends Area2D
class_name Room

signal player_entered()

func _on_body_entered(body: Node2D) -> void:
	print("body entered room")
	if body.is_in_group("player"):
		player_entered.emit()

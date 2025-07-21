extends Node2D
class_name Portal

signal exited()

@onready var friend: Friend = get_tree().get_first_node_in_group(&"friend")

var locked := true

#func _ready() -> void:
	#friend.freed.connect(_on_friend_freed)
	
func _on_friend_freed() -> void:
	locked = false
	$Locked.hide()
	$Unlocked.show()

func _on_body_entered(body: Node2D) -> void:
	print("player entered portal area")
	if not locked and body.is_in_group(&"player"):
		print("Player exited through portal")
		exited.emit()

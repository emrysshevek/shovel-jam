extends Camera2D
class_name WorldCamera

@export var rooms: Array[Room] = []

func _ready() -> void:
	for room in rooms:
		room.player_entered.connect(transition_to_room.bind(room))

func transition_to_room(room: Room) -> void:
	get_tree().paused = true
	var tween = create_tween()
	tween.tween_property(self, ^"global_position", room.global_position, .25)
	tween.finished.connect(get_tree().set_deferred.bind("paused", false))
	

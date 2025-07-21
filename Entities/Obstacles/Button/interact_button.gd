extends Sprite2D
class_name InteractButton

func _ready() -> void:
	var pos = global_position
	var tween = create_tween().set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, ^"global_position", pos + Vector2(0, 100), 1)
	tween.tween_property(self, ^"global_position", pos, 1)

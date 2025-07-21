extends Sprite2D

var obscuredColor = Color(0.6, 0.6, 0.6)
var clearColor = Color(1, 1, 1)


func _on_button_r_button_down():
	modulate = obscuredColor;

func _on_button_r_button_up():
	modulate = clearColor;

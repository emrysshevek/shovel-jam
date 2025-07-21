extends Sprite2D

var current = 0;

var TEXTURE_VARIATION_ARRAY: Array = [
	preload("./ghost_assets/ghost_arrow_A.png"),
	preload("./ghost_assets/ghost_arrow_B.png")
]


func variate_texture():
	#Separate files approach
	if current == 0:
		current += 1;
		var chosen_texture: Texture = TEXTURE_VARIATION_ARRAY[current];
		texture = chosen_texture;
	else:
		current -= 1;
		var chosen_texture: Texture = TEXTURE_VARIATION_ARRAY[current];
		texture = chosen_texture;


func _on_timer_timeout():
	variate_texture();

extends Node2D

@export var hits_to_break := 1
@onready var detection_area := $Hitbox/Area/Detection_Area

var colliding_with_player: bool 


func reduce_strength():
	hits_to_break -= 1
	if hits_to_break <= 0: 
		if OS.is_debug_build(): print("Object Destroyed")
		queue_free()

func _on_hitbox_entered(body:Node):
	if body is Player:
		colliding_with_player = true

func _on_hitbox_exited(body:Node):
	if body is Player:
		colliding_with_player = false


func _on_detection_area_body_entered(body:Node2D):
	if body is Player:
		reduce_strength()
		if OS.is_debug_build():
			print("Hit Detected! Hits left to break: %d" % hits_to_break)

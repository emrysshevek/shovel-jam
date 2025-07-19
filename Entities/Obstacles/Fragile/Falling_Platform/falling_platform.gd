extends Node2D

@export var structure := 100
@export var damage_per_turn:= 1
@onready var raycast := $Hitbox/RayCast2D

var colliding_with_player: bool 


func _process(_delta):
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider is Player:
			reduce_strength()
			print("Current Structure %d" % structure)
	pass

func reduce_strength():
	structure -= damage_per_turn
	if structure <= 0: 
		queue_free()

func _on_hitbox_entered(body:Node):
	if body is Player:
		colliding_with_player = true

func _on_hitbox_exited(body:Node):
	if body is Player:
		colliding_with_player = false

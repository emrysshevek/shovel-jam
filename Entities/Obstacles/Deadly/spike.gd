extends Node2D


@export var damage_amount := 1

func _ready():
    pass

func _on_hitbox_entered(body:Node2D):
    if body is Player:
        body.take_damage(damage_amount)

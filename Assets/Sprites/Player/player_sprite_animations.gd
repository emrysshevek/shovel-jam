extends Node2D
class_name PlayerSpriteAnimations

signal step()

func foot_down() -> void:
	step.emit()

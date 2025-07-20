extends Node

@export var gravity := 5000.0

const num_stages := 4
var stage_data := []

func _ready() -> void:
	for i in range(num_stages):
		stage_data.append({
			"unlocked": false,
			"complete": false,
			"score": 0
		})
	
	stage_data[0]["unlocked"] = true
	
func complete_level(level: int, score: float) -> void:
	stage_data[level]["complete"] = true
	stage_data[level]["score"] = score
	if level < len(stage_data) - 1:
		stage_data[level + 1]["unlocked"] = true

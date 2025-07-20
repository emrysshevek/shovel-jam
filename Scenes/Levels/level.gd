extends Node2D
class_name Level

signal completed(score: float)

@export var level := 0
@export var music: AudioStream

@onready var data = Globals.stage_data[level]
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var friend: Friend = get_tree().get_first_node_in_group("friend")
@onready var portal: Portal = $Environment/Portal

func _ready() -> void:
	MusicManager.crossfade_to(music)
	friend.freed.connect(_on_friend_freed)
	portal.exited.connect(_on_portal_entered)
	

func _on_friend_freed() -> void:
	for grav_comp: Gravity in find_children("*", "Gravity"):
		grav_comp.enabled = false

func _on_portal_entered() -> void:
	Globals.complete_level(level, 1000)
	completed.emit()
	get_tree().change_scene_to_file.call_deferred("res://Scenes/Hub/overworld.tscn")

extends Node2D

@export var music: AudioStream
@export var globes: Array[Globe]

@onready var camera: Camera2D = $Camera2D
@onready var player: Player = $Stuff/PlayerSpawn/Player

var started = false

func _ready() -> void:
	MusicManager.play_music(music)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause"):
		MusicManager.play_sfx("res://Assets/Audio/SFX/pause game.wav")
		$CanvasLayer2/Pause_UI.show()
		get_tree().paused = true
	if not started and event.is_action_pressed(&'start'):
		MusicManager.play_sfx("res://Assets/Audio/SFX/enter game-enter level.wav")
		$AnimationPlayer.play("start")
		started = true
		for globe in $Stuff/Layout/Levels.get_children():
			globe.active = true

func _process(delta: float) -> void:
	if started:
		camera.global_position = player.global_position
		camera.global_position.y -= 700

func _on_bottom_area_body_entered(body: Node2D) -> void:
	player.global_position = $Stuff/PlayerSpawn.global_position

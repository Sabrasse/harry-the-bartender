extends Node2D

@onready var button = $Board/Control/StartButton
@onready var timer = $Spawn/Timer
@onready var character: Area2D = %Character

signal game_started

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	## Change gameover to timeout instead of character
	## character.game_over.connect(_on_game_over)

func _on_button_pressed():
	timer.start()
	game_started.emit()

func _on_game_over():
	get_tree().reload_current_scene()

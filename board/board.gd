extends Node2D
@onready var start: Node2D = $".."

## Refacto to manage the logic in a UI scene instead ?

func _ready() -> void:
	start.game_started.connect(_on_game_started)
	
func _on_game_started():
	self.hide()

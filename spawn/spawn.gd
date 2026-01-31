extends Node2D
@onready var timer: Timer = $Timer
var GlassScene = preload("res://items/glass.tscn")

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var glass = GlassScene.instantiate()
	add_child(glass)
	var random_axis_x = randi_range(300, 900)
	glass.position = Vector2(random_axis_x, 320)

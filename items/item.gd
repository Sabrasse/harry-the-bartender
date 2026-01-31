extends Area2D

@export var throw_speed: int = 300
@export var rotation_angle: float = 10.0
@export var item_damage : int = 5

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area_entered: Area2D):
	if area_entered.is_in_group("throwable"):
		queue_free()

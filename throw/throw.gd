extends Node2D

@onready var timer: Timer = $Timer
@export var items: Array[PackedScene] = []

var item: Area2D
var velocity := Vector2(0,0)

func _ready() -> void:
	print(items)
	timer.timeout.connect(_on_timeout)

func _process(delta: float) -> void:
	if is_instance_valid(item):
		item.position += velocity * delta
		item.rotate(item.rotation_angle * delta)
		
func _on_timeout():
	_spawn_new_item()

func _spawn_new_item():
	# Refacto here, not sure about spawning items in the throw scope
	print(items)
	item = items.pick_random().instantiate()
	var random_axis_x := randi_range(0, 1100)
	add_child(item)
	item.position = Vector2(random_axis_x,600)
	_throw_item_to_character(item)
	
func _throw_item_to_character(item):        
	var direction := Vector2(0,0)
	var target_pos = %Character.position
	direction = (target_pos - item.position).normalized()
	velocity = direction * item.throw_speed

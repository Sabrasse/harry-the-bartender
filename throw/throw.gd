extends Node2D

var glass_scene = preload("res://glass/glass.tscn")
var glass: Area2D
var speed := 300
var velocity := Vector2(0,0)
var items_thrown := 0

func _ready() -> void:
	get_node("Timer").timeout.connect(_on_timeout)
	spawn_new_item()
	throw_item_to_character()

func _process(delta: float) -> void:
	if is_instance_valid(glass):
		glass.position += velocity * delta
		glass.rotate(10 * delta)
		
func _on_timeout():
	spawn_new_item()
	throw_item_to_character()

func spawn_new_item():
	var random_axis_x := randi_range(-600, 600)
	glass = glass_scene.instantiate()
	add_child(glass)
	glass.position = Vector2(random_axis_x,600)
	items_thrown += 1

func throw_item_to_character():
	var direction := Vector2(0,0)
	var target_pos = %Character.position
	direction = (target_pos - glass.position).normalized()
	velocity = direction * speed

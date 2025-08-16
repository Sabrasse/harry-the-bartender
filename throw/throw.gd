extends Node2D

var items := [
    preload("res://items/glass.tscn"),
    preload("res://items/bottle.tscn"),
    preload("res://items/plant.tscn"),
    preload("res://items/stool.tscn")
]

var throws := []

var item: Area2D
var velocity := Vector2(0,0)

func _ready() -> void:
    get_node("Timer").timeout.connect(_on_timeout)

func _process(delta: float) -> void:
    if is_instance_valid(item):
        item.position += velocity * delta
        item.rotate(item.rotation_angle * delta)
        
func _on_timeout():
    spawn_new_item(items)

func spawn_new_item(scenes: Array):
    var random_scene = scenes.pick_random()
    item = random_scene.instantiate()
    var random_axis_x := randi_range(0, 1100)
    add_child(item)
    item.position = Vector2(random_axis_x,600)
    throw_item_to_character(item)
    
func throw_item_to_character(item):        
    var direction := Vector2(0,0)
    var target_pos = %Character.position
    direction = (target_pos - item.position).normalized()
    velocity = direction * item.throw_speed

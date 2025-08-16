extends Area2D

var health := 100
var speed := 300
var direction := Vector2(0,0)
var velocity := Vector2(0,0)

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	set_health(health)

func _process(delta: float) -> void:
	var viewport_size = get_viewport_rect().size
	position.x = wrapf(position.x, 0, viewport_size.x)
	
	direction.x = Input.get_axis("left", "right")
	velocity = speed * direction
	position += velocity * delta
	
func _on_area_entered(area_entered: Area2D):
	set_health(health - 20)

func set_health(new_health: int):
	health = new_health
	$Control/ProgressBar.value = health
	if health < 1:
		get_tree().reload_current_scene()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		position.y += 60
		get_node("CollisionShape2D").position.y /= 2
	if event.is_action_released("down"):
		position.y -= 60

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
	var sprite2D = get_node("Sprite2D")
	
	position.x = wrapf(position.x, 0, viewport_size.x)
	
	direction.x = Input.get_axis("left", "right")
	if direction.x < 0:
		sprite2D.scale.x = -0.5
	elif direction.x > 0:
		sprite2D.scale.x = 0.5
		
	velocity = speed * direction
	position += velocity * delta
	
func _on_area_entered(area_entered: Area2D):
	var damage = area_entered.item_damage
	set_health(health - damage)

func _input(event: InputEvent) -> void:
	duck(event)
	
func set_health(new_health: int):
	health = new_health
	$Control/ProgressBar.value = health
	if health < 1:
		get_tree().reload_current_scene()

func duck(event: InputEvent):
	if event.is_action_pressed("down"):
		position.y += 60
	if event.is_action_released("down"):
		position.y -= 60

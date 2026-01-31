extends Area2D

@onready var sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed: int = 300
var direction: Vector2 = Vector2(0, 0)
var velocity: Vector2 = Vector2(0, 0)

var fill_glass = false
signal glass_filling

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _process(delta: float) -> void:
	## What's the purpose of this ?
	var viewport_size = get_viewport_rect().size
	position.x = wrapf(position.x, 0, viewport_size.x)
	
	## Refacto in one dedicated function
	direction.x = Input.get_axis("left", "right")
	if direction.x < 0:
		sprite2D.scale.x = -0.5
	elif direction.x > 0:
		sprite2D.scale.x = 0.5
		
	velocity = speed * direction
	position += velocity * delta
	
func _on_area_entered(area_entered: Area2D):
	## Change to emit a signal to the score instead
	if area_entered.is_in_group("throwable"):
		animation_player.play("hurt")
		
	if area_entered.is_in_group("glass"):
		fill_glass = true

func _on_area_exited():
	fill_glass = false
	pass

func _input(event: InputEvent) -> void:
	duck(event)
	filling_glass(event)

func duck(event: InputEvent):
	## Cleaner refacto ?
	if event.is_action_pressed("down"):
		position.y += 60
	if event.is_action_released("down"):
		position.y -= 60
	
func filling_glass(event: InputEvent):
	## Works
	if event.is_action_pressed("action") and fill_glass:
		print("Filling glass")
		glass_filling.emit()

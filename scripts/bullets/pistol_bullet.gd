extends Bullet

@export var speed: float = 320.0      
@export var max_distance: float = 180 
var facing_of: Vector2 = Vector2.RIGHT
var start_position: Vector2
var fire_rate: float = 0.3

func _ready():
	start_position = global_position

func _process(delta: float):
	global_position += facing_of.normalized() * speed * delta
	if global_position.distance_to(start_position) >= max_distance:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	queue_free()

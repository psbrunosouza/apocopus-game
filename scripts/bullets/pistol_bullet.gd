extends Bullet

@export var speed: float = 450.0      
@export var max_distance: float = 180 
var equipment_resource: ModuleResource
var facing: Vector2
var start_position: Vector2
var fire_rate: float = 0.3

func _ready():
	rotation = facing.angle()
	start_position = global_position

func create_shatter_effect():
	var shatter_effect_scene = load(equipment_resource.shatter_effect_path)
	var shatter_effect = shatter_effect_scene.instantiate()
	shatter_effect.global_position = global_position
	get_parent().add_child(shatter_effect)

func _process(delta: float):
	global_position += facing.normalized() * speed * delta
	if global_position.distance_to(start_position) >= max_distance:
		create_shatter_effect()
		queue_free()

func _on_body_entered(_body: Node2D) -> void:
	create_shatter_effect()
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	create_shatter_effect()
	queue_free()

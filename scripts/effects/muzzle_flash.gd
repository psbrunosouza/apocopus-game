extends AnimatedSprite2D

var facing: Vector2 = Vector2.RIGHT

func _ready() -> void:
	rotation = facing.angle()

func _on_animation_finished() -> void:
	queue_free()

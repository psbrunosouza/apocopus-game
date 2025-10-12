extends Node

var scale_factor: Vector2 = Vector2.ONE
var base_resolution: Vector2 = Vector2(320, 180)

func _ready() -> void:
	_update_scale()

func _update_scale() -> void:
	var res = get_viewport().get_visible_rect().size
	scale_factor = res / base_resolution

func get_uniform_scale() -> float:
	_update_scale()
	return min(scale_factor.x, scale_factor.y)

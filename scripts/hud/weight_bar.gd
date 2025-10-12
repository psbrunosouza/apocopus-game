@tool

extends Control

@export var border: TextureRect
@export var bar: TextureRect
@export var bar_width: int

var weight: int

func _ready() -> void:
	_update_bar_data()
	_update_bar_size()

func _update_bar_data():
	weight = GameManager.weight
	
func _update_bar_size():
	border.position.x = 0
	bar.position.x = 1
	
	var max_bar_width = bar_width * weight
	
	border.size.x = max_bar_width + 2
	bar.size.x = max_bar_width

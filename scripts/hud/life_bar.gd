@tool

extends Control

signal bar_resized(bar_width)

@export var life_bar_border: TextureRect
@export var life_bar_filled: TextureRect
@export var life_bar_empty: TextureRect
@export var life_bar_width: int

var max_life: int
var life: int
var weight: int
var available_life: int

func _ready() -> void:
	_update_lifebar_data()
	_update_available_life()
	_update_life_bar_size()

func _update_lifebar_data():
	max_life = GameManager.max_life
	life = GameManager.life
	weight = GameManager.weight
	
func _update_available_life():
	available_life = max_life - weight
	
func _update_life_bar_size():
	life_bar_border.position.x = 0
	life_bar_empty.position.x = 1
	
	var max_lifebar_width = life_bar_width * available_life
	var lifebar_width
	if life <= available_life:
		lifebar_width = life_bar_width * life
	else:
		life = available_life
		lifebar_width = life_bar_width * life
	
	life_bar_border.size.x = max_lifebar_width + 2
	life_bar_empty.size.x = max_lifebar_width
	
	life_bar_filled.position.x = 1
	life_bar_filled.size.x = lifebar_width
	
	emit_signal("bar_resized", life_bar_border.size.x)

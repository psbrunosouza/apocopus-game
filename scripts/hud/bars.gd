extends ResizeWrapperControl

@export var life_bar: Control
@export var weight_bar: Control

func _ready() -> void:
	life_bar.position.x = 0

func _on_life_bar_bar_resized(bar_width: Variant) -> void:
	weight_bar.position.x = bar_width - 1

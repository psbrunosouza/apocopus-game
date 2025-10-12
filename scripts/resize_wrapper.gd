extends Control

class_name ResizeWrapperControl

func _process(_delta: float) -> void:
	scale = Vector2.ONE * ResolutionManager.get_uniform_scale()

func _notification(what):
	if what == NOTIFICATION_RESIZED:
		scale = Vector2.ONE * ResolutionManager.get_uniform_scale()

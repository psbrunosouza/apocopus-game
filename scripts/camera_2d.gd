extends Camera2D

func _draw():
	get_viewport_rect()
	draw_rect(Rect2(global_position - get_viewport_rect().size / 2, get_viewport_rect().size), Color(1, 0, 0, 0.3))
	get_viewport_rect()

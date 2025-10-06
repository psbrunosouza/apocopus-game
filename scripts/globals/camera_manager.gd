extends Node

func set_camera_limits(world: Node, left: int, right: int, top: int, bottom: int):
	var player = world.get_node("Player") as Player
	player.camera.limit_left = left
	player.camera.limit_right = right
	player.camera.limit_top = top
	player.camera.limit_bottom = bottom

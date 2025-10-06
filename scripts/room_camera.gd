extends Camera2D

class_name RoomCamera

@onready var player = get_node("/root/World/Player")

func _process(_delta: float) -> void:
	global_position = player.global_position

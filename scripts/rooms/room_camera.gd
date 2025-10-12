extends Camera2D

class_name RoomCamera

@onready var player = get_tree().get_nodes_in_group("player")[0]

func _process(_delta: float) -> void:
	global_position = player.global_position
	

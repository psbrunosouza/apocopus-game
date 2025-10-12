extends Area2D

@export var connected_room: Node2D
@export var player_pos: Vector2
@export var player_jumping_on_enter: bool = false
@export var origin: String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		RoomManager.is_activate = true
		RoomManager.player_pos = player_pos
		RoomManager.player_jumping_on_enter = player_jumping_on_enter
		RoomManager.connected_room = connected_room
		RoomManager.origin = origin
		RoomManager.change_room()

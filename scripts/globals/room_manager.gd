extends Node

var is_activate: bool = false 
var player_pos: Vector2 
var player_jumping_on_enter: bool
var connected_room: Node2D
var origin: String

@onready var world = get_tree().current_scene
@onready var player = world.get_node("Player") as CharacterBody2D

func change_room():
	if is_activate:
		var camera = connected_room.get_node("RoomCamera") as Camera2D
		camera.make_current()
		var tween = create_tween()
		player.global_position = player_pos
		match origin:
			"left":
				var cam_to = camera.limit_left
				var cam_from = camera.limit_left - 200
				camera.limit_left = cam_from
				tween.tween_property(camera, "limit_left", cam_to, 0.2)
			"right":
				var cam_to = camera.limit_right
				var cam_from = camera.limit_right + 200
				camera.limit_right = cam_from
				tween.tween_property(camera, "limit_right", cam_to, 0.2)
			"top":
				pass
			"bottom":
				pass
		
		is_activate = false

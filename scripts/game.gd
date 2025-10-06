extends Node2D

@export var menu: CanvasLayer
@export var in_game_elements: Node

func _ready() -> void:
	#menu.hide()
	pass

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed(Pad.START):
		if !menu.visible:
			menu.show()
			in_game_elements.process_mode = Node.PROCESS_MODE_DISABLED
			GameManager.is_paused = true
		else:
			menu.hide()
			in_game_elements.process_mode = Node.PROCESS_MODE_INHERIT
			GameManager.is_paused = false

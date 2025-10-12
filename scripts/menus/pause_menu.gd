extends CanvasLayer

@export var game: Node2D
@export var actions: VBoxContainer

func _ready() -> void:
	hide()
	
func _process(_delta: float) -> void:
	handle_action_click()
	toggle_pause_menu()

func handle_action_click():
	if visible and Input.is_action_just_pressed(Pad.A):
		var focused_action = get_viewport().gui_get_focus_owner() as Button
		focused_action.pressed.emit()

func toggle_pause_menu(): 
	if Input.is_action_just_pressed(Pad.START) and not visible:
		game.process_mode = game.PROCESS_MODE_DISABLED
		show()
		if actions.get_child_count() > 0:
			actions.get_children()[0].grab_focus()
	elif Input.is_action_just_pressed(Pad.START) and visible:
		game.process_mode = game.PROCESS_MODE_INHERIT
		hide()

func _on_resume_pressed() -> void:
	game.process_mode = game.PROCESS_MODE_INHERIT
	hide()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

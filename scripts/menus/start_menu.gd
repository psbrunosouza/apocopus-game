extends CanvasLayer

@export var start: Button
@export var quit: Button
@export var actions: VBoxContainer

func _ready() -> void:
	if actions.get_child_count() > 0:
		actions.get_children()[0].grab_focus()

func _process(_delta: float) -> void:
	handle_action_click()

func handle_action_click():
	if visible and Input.is_action_just_pressed(Pad.A):
		var focused_action = get_viewport().gui_get_focus_owner() as Button
		focused_action.pressed.emit()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

extends Area2D

signal selection_toggle(selection)

export var exclusive = true
export var selection_action = "ui_accept"

var selected = false setget set_selected

func set_selected(selection):
	if selection:
		_make_exclusive()
		add_to_group("selected")
	else :
		remove_from_group("selected")
	selected = selection
	emit_signal("selection_toggle", selected)

func _make_exclusive():
	if not selected :
		return
	get_tree().call_group("selected", "set_selected", false)

func _input_event(_viewport, _event, _shape_idx):
	if _event.is_action_pressed(selection_action):
		set_selected(not selected)

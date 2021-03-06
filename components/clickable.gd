extends Area2D

signal on_click(button_index)

const VALID_BUTTONS=[BUTTON_LEFT, BUTTON_RIGHT, BUTTON_MIDDLE]

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index in VALID_BUTTONS\
	and event.is_pressed():
		emit_signal("on_click", event.button_index)

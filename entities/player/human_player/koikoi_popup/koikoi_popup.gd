extends PopupDialog

signal option_selected(option)

func _on_button_pressed(value: bool):
	emit_signal("option_selected", value)
	hide()

extends PopupDialog

signal option_selected(option)

func show():
	show_modal(true)

func _on_button_pressed(value: bool):
	emit_signal("option_selected", value)
	hide()

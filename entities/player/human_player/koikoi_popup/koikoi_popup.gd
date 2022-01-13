extends PopupDialog

signal option_selected(option)

func set_points(points:int):
	$PointsLabel.text="Points: "+String(points)

func _on_button_pressed(value: bool):
	emit_signal("option_selected", value)
	hide()

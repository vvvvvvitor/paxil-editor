extends ColorPickerButton
class_name ColorPickerPreviewButton

signal color_accepted
signal color_pressed


# Called when the node enters the scene tree for the first time.
func _init():
	color_changed.connect(__on_new_color)
	gui_input.connect(__on_input)
	popup_closed.connect(__on_popup_close)
	modulate = color
	get_popup().transparent_bg = true


func __on_new_color(new_color):
	modulate = new_color


func __on_popup_close():
	emit_signal("color_accepted", self, color)


func __on_input(event):
	if event is InputEventMouseButton:
		if event.button_index in [MOUSE_BUTTON_LEFT, MOUSE_BUTTON_RIGHT, MOUSE_BUTTON_MIDDLE]:
			if event.pressed:
				emit_signal("color_pressed", self, event.button_index)

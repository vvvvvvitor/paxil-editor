extends ColorPickerButton
class_name ColorPickerPreviewButton

# Called when the node enters the scene tree for the first time.
func _init():
	color_changed.connect(__on_new_color)
	
	
func __on_new_color(new_color):
	modulate = new_color

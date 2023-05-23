extends ColorPickerPreviewButton


@export var secondary:bool = false

var current_workspace = Core.current_workspace.workspace


# Called when the node enters the scene tree for the f irst time.
func _init():
	color_changed.connect(_on_new_color)
	color = current_workspace.primary_color if !secondary else current_workspace.secondary_color 
	super()


func _on_new_color(new_color):
	if !secondary:
		current_workspace.primary_color = new_color
	else: current_workspace.secondary_color = new_color

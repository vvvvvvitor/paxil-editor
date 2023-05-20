extends ColorPickerPreviewButton


@export var secondary:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	color_changed.connect(_on_new_color)
	
	color = owner.get_meta("tool").primary_color if !secondary else owner.get_meta("tool").secondary_color 
	modulate = color


func _on_new_color(new_color):
	if !secondary:
		owner.get_meta("tool").primary_color = new_color
	else: owner.get_meta("tool").secondary_color = new_color

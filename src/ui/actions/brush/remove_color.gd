extends Button


@export var color_pallete:ColorPallete


func _ready():
	pressed.connect(_on_press)
	
	
func _on_press():
	color_pallete.remove_color(color_pallete.get_pallete().size() - 1)

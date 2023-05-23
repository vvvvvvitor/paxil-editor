extends Button


@export var color_pallete:ColorPallete


func _ready():
	pressed.connect(_on_press)
	
	
func _on_press():
	color_pallete.add_color(Color.BLACK)

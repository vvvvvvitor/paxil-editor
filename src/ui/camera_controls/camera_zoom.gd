extends Button

@export var zoom_amount:float = 0.1


# Called when the node enters the scene tree for the first time.
func _ready():
		pressed.connect(_on_press)
		
		
func _on_press():
	Core.current_workspace.get_camera_2d().emit_signal("zoom_changed", zoom_amount)

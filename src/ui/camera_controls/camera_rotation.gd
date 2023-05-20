extends Button


@export var rotation_amount:float = PI / 4


# Called when the node enters the scene tree for the first time.
func _ready():
		pressed.connect(_on_press)
		
		
func _on_press():
	Core.current_workspace.get_camera_2d().emit_signal("rotation_changed", Core.current_workspace.get_camera_2d().rotation + rotation_amount)

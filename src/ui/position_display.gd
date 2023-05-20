extends Label


func _process(delta):
	text = str(Core.current_workspace.get_camera_2d().global_position.floor())

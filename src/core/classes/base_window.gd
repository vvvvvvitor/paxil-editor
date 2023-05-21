extends Window
class_name BaseWindow


# Called when the node enters the scene tree for the first time.
func _ready():
	close_requested.connect(__on_close_request)
	
	
func __on_close_request():
	queue_free()


static func create_with_size(width:int, height:int, min_width:int = 0, min_height:int = 0) -> BaseWindow:
	var new_window = BaseWindow.new()
	
	new_window.size = Vector2(width, height)
	new_window.min_size = Vector2(min_width, min_height)
	
	return new_window

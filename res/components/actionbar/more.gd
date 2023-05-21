extends MenuButton

const ABOUT_WINDOW = preload("res://res/components/popups/about.tscn")


# Called when the node enters the scene tree for the first time.
func _init():
	get_popup().transparent_bg = true
	get_popup().id_pressed.connect(_on_selection)
	

func _on_selection(id):
	if id == 0:
		Core.create_window_popup(ABOUT_WINDOW)

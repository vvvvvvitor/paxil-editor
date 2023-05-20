extends Control
class_name ContextMenuContainer

var context_menu:PopupMenu


func _ready():
	for child in get_children():
		if child is PopupMenu:
			context_menu = child
			
	if context_menu:
		gui_input.connect(_on_input)
	
	
func _on_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				var world_to_view = get_canvas_transform()
				var view_position = world_to_view * get_global_mouse_position()
				context_menu.position = view_position
				context_menu.popup()

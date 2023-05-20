extends Control

signal window_state_changed
signal remove_window

enum WINDOW_STATES {
	NOT_FOCUSED,
	FOCUSED
}

var canvas_size:Vector2

var window_state:WINDOW_STATES = WINDOW_STATES.NOT_FOCUSED:
	set(val):
		window_state = val
		emit_signal("window_state_changed", window_state)


func get_canvas_container() -> PanelContainer:
	return $Backdrop/HBoxContainer/CanvasContainer


func _ready():
	window_state_changed.connect(_on_window_state)
	#context_menu_container.context_menu.id_pressed.connect(_on_context_pressed)
	remove_window.connect(_on_removal)
	
	var new_canvas = Canvas.create_canvas(canvas_size.x, canvas_size.y)
	new_canvas.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	new_canvas.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	new_canvas.custom_minimum_size = new_canvas.image_buffer.get_size() * Core.CANVAS_AMPLIFICATION
	new_canvas.mouse_filter = MOUSE_FILTER_PASS
	get_canvas_container().add_child(new_canvas)


func _on_removal():
	queue_free()


func _on_context_pressed(id):
	if id == 0:
		emit_signal("remove_window")


func _on_window_state(state:WINDOW_STATES):
	match state:
		WINDOW_STATES.NOT_FOCUSED:
			pass
		WINDOW_STATES.FOCUSED:
			move_to_front()


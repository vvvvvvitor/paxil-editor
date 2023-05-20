extends PanelContainer

signal dragging_started

var initial_position = Vector2.ZERO
var dragging = false


func _ready():
	gui_input.connect(_on_input)


func _input(event):
	if event is InputEventMouseMotion:
		if dragging:
			owner.position = get_global_mouse_position() + initial_position
			if Input.is_action_pressed("action_secondary"):
				owner.position = (get_global_mouse_position() + initial_position).snapped(Vector2.ONE * Core.CANVAS_AMPLIFICATION)

func _on_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				initial_position = owner.position - get_global_mouse_position()
				owner.window_state = 1
			dragging = event.pressed
#			if !dragging:
#				if event.double_click:
#					get_viewport().get_camera_2d().global_position = owner.global_position + owner.size / 2


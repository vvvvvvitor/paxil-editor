extends BoxContainer
#class_name ResizableContainer
#
#@export var margin:int = 32
#
#@onready var initial_size = size
#@onready var initial_position = position
#
#enum RESIZE_STATES {
#	IDLE,
#	HORIZONTAL,
#	VERTICAL
#}
#
#var resize_direction:Vector2 = Vector2.ZERO
#
#var can_resize_x:bool = false
#var can_resize_y:bool = false
#
#var resize_state:RESIZE_STATES = RESIZE_STATES.IDLE
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	gui_input.connect(_on_input)
#
#
#func _on_input(event):
#	if event is InputEventMouseMotion:
#		if get_local_mouse_position().x > size.x - margin || get_local_mouse_position().x < 0 + margin:
#			mouse_default_cursor_shape = Control.CURSOR_HSIZE
#			can_resize_x = true
#		elif get_local_mouse_position().y > size.y - margin || get_local_mouse_position().y < 0 + margin:
#			mouse_default_cursor_shape = Control.CURSOR_VSIZE
#			resize_direction = Vector2(0, sign(get_local_mouse_position().y - (size.y / 2)))
#			can_resize_y = true
#		else:
#			can_resize_x = false
#			can_resize_y = false 
#			mouse_default_cursor_shape = Control.CURSOR_ARROW
#
#
#func _input(event):
#	if event is InputEventMouseMotion:
#		match resize_state:
#			RESIZE_STATES.IDLE:
#				pass
#			RESIZE_STATES.HORIZONTAL:
#				size.x = get_local_mouse_position().x * resize_direction.x
#				if resize_direction.x == -1:
#					position.x = initial_position.x - (size.x - initial_size.x)
#			RESIZE_STATES.VERTICAL:
#				size.y = get_local_mouse_position().y
#
#	if event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_LEFT:
#			if event.pressed:
#				if can_resize_x:
#					initial_size = size
#					initial_position = position
#					resize_direction = Vector2(sign(get_local_mouse_position().x - (size.x / 2)), 0)
#					resize_state = RESIZE_STATES.HORIZONTAL
#				elif can_resize_y:
#					initial_size = size
#					resize_state = RESIZE_STATES.VERTICAL
#			else:
#				resize_state = RESIZE_STATES.IDLE
#

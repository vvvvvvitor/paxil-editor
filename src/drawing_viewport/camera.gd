extends Camera2D
class_name WorkspaceCamera


signal zoom_changed
signal rotation_changed

const MAX_ZOOM = 32
const MIN_ZOOM = 0.1
const DRAG_SENSITIVITY = 0.065

enum CAMERA_MODES {
	STATIONARY,
	DRAGGING,
	ROTATING
}

var rotating:bool = false
var drag_position:Vector2 = Vector2.ZERO
var camera_mode:CAMERA_MODES = CAMERA_MODES.STATIONARY


func _ready():
	zoom_changed.connect(_on_zoom)
	rotation_changed.connect(_on_rotation)


func _input(event):
	if event is InputEventMouseMotion:
		match camera_mode:
			CAMERA_MODES.STATIONARY:
				drag_position = get_global_mouse_position()
			CAMERA_MODES.DRAGGING:
				position += (drag_position - get_global_mouse_position())
		
		
	if event is InputEvent:
		if event.is_action_pressed("action_secondary"):
			rotating = true
		elif event.is_action_released("action_secondary"):
			rotating = false
		if event.is_action_pressed("action_move"):
			camera_mode = CAMERA_MODES.DRAGGING
		elif event.is_action_released("action_move"): 
			camera_mode = CAMERA_MODES.STATIONARY
	
	
	if event is InputEventMouseButton:
		if camera_mode != CAMERA_MODES.ROTATING:
			match event.button_index:
				MOUSE_BUTTON_WHEEL_DOWN:
					if rotating:
							emit_signal("rotation_changed", rotation - PI/4)
							return
					emit_signal("zoom_changed", -0.25)
				MOUSE_BUTTON_WHEEL_UP:
					if rotating:
						emit_signal("rotation_changed", rotation + PI/4)
						return
					emit_signal("zoom_changed", 0.25)



func _on_zoom(amount):
	zoom_in_out(amount)


func _on_rotation(amount:float):
	camera_mode = CAMERA_MODES.ROTATING
	var rotation_tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	rotation_tween.tween_property(self, "rotation", amount, 0.1)
	await rotation_tween.finished
	camera_mode = CAMERA_MODES.STATIONARY


func zoom_in_out(amount:float):
	var zoom_tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var new_zoom = clamp(zoom + Vector2.ONE * amount, Vector2.ONE * MIN_ZOOM, Vector2.ONE * (MAX_ZOOM - 0.1))
	zoom_tween.tween_property(self, "zoom", new_zoom, 0.2)

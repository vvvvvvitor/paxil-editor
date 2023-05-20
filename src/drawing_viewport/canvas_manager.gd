extends Node2D
class_name CanvasManager

const CANVAS_WINDOW = preload("res://res/components/canvas_window.tscn")

const FONT:Font = preload("res://res/fonts/futura medium bt.ttf")
var click_count = 0
var canvas_rect:Rect2 = Rect2(0, 0, 0, 0)
var creating = false
var valid = true


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		queue_redraw()
		if creating:
			var mouse_pos = get_local_mouse_position()
			canvas_rect.size = mouse_pos.snapped(Vector2.ONE * Core.CANVAS_AMPLIFICATION)
			
			var canvas_resolution = CoreMath.get_rect_local_size(canvas_rect) / Core.CANVAS_AMPLIFICATION
			valid = abs(canvas_resolution.x) > 0 && abs(canvas_resolution.y) > 0
			#if Input.is_action_pressed("action_secondary"):
			#	canvas_rect.size = Vector2.ONE * snapped(mouse_pos[mouse_pos.max_axis_index()], Core.CANVAS_AMPLIFICATION)
			#	print(Vector2.ONE * snapped(mouse_pos[mouse_pos.max_axis_index()], Core.CANVAS_AMPLIFICATION), canvas_rect.size)
				
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if !event.pressed:
				if creating:
					creating = false
					var canvas_resolution = CoreMath.get_rect_local_size(canvas_rect) / Core.CANVAS_AMPLIFICATION
					
					if valid:
						create_canvas_window(canvas_rect)
					queue_redraw()

			if event.double_click:
				canvas_rect.position = get_global_mouse_position().snapped(Vector2.ONE * Core.CANVAS_AMPLIFICATION)
				creating = true


func _draw():
	if creating:
		draw_canvas_preview(canvas_rect.position, canvas_rect.size, Color.BLACK if valid else Color.RED)


func create_canvas_window(canvas_rect:Rect2):
	var canvas_resolution = CoreMath.get_rect_local_size(canvas_rect) / Core.CANVAS_AMPLIFICATION
	
	var canvas_window = CANVAS_WINDOW.instantiate()
	canvas_window.canvas_size = canvas_resolution
	
	add_child(canvas_window)
	
	canvas_window.global_position = canvas_rect.position - (canvas_resolution * Core.CANVAS_AMPLIFICATION * Vector2(int(canvas_resolution.x > 0), int(canvas_resolution.y > 0)))


func draw_canvas_preview(starting_position, ending_position, color:Color):
	draw_line(starting_position, Vector2(starting_position.x, ending_position.y), color)
	draw_line(Vector2(starting_position.x, ending_position.y), Vector2(ending_position.x, ending_position.y), color)
	draw_string(FONT, ending_position + Vector2(0, 16), str(abs(canvas_rect.position - canvas_rect.size) / Core.CANVAS_AMPLIFICATION))

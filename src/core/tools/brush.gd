extends Tool

const ACTION:PackedScene = preload("res://res/components/actions/brush_action.tscn")

enum DRAWING_STATES {
	IDLE,
	HOLDING_LEFT,
	HOLDING_RIGHT
}


var primary_color:Color = Color.WHITE
var secondary_color:Color = Color.WHITE

var drawing_state:DRAWING_STATES = DRAWING_STATES.IDLE


func _init():
	tool_name = "tool"
	tool_icon = load("res://res/textures/icons/pen-16x.png")


func _actionbar_init(action_bar:PanelContainer):
	action_bar.set_action(ACTION)


var last_point:Vector2 = Vector2.ONE
func _canvas_input(canvas:Canvas, event:InputEvent):
	if event is InputEventMouseMotion:
		match drawing_state:
			DRAWING_STATES.HOLDING_LEFT, DRAWING_STATES.HOLDING_RIGHT:
				var current_pos = event.position / Core.CANVAS_AMPLIFICATION
				if current_pos.distance_to(last_point.snapped(Vector2.ONE)) > 0.5:
					canvas.draw_line_on_canvas(
						last_point, 
						current_pos, 
						primary_color if drawing_state == 1 else secondary_color, 
						Canvas.COLOR_MODE.NORMAL if primary_color.a == 1 else Canvas.COLOR_MODE.ADDITIVE,
					)
					last_point = event.position / Core.CANVAS_AMPLIFICATION
			DRAWING_STATES.IDLE:
				pass

	if event is InputEventMouseButton:
		if event.button_index in [MOUSE_BUTTON_LEFT, MOUSE_BUTTON_RIGHT]:
			last_point = event.position / Core.CANVAS_AMPLIFICATION
			drawing_state = event.button_index * int(event.pressed)
			if event.pressed:
				canvas.draw_point_on_canvas(last_point, primary_color if event.button_index == 1 else secondary_color, Canvas.COLOR_MODE.NORMAL if primary_color.a == 1 else Canvas.COLOR_MODE.ADDITIVE)

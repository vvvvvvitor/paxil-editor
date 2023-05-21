extends Tool

const ACTION:PackedScene = preload("res://res/components/actions/eraser_action.tscn")

enum DRAWING_STATES {
	IDLE,
	HOLDING,
}


var drawing_state:DRAWING_STATES = DRAWING_STATES.IDLE

func _init():
	tool_name = "Eraser"
	tool_icon = load("res://res/textures/icons/eraser-16x.png")


func _actionbar_init(action_bar:PanelContainer):
	action_bar.set_action(ACTION)


var last_point:Vector2 = Vector2.ONE
func _canvas_input(canvas:Canvas, event:InputEvent):
	if event is InputEventMouseMotion:
		match drawing_state:
			DRAWING_STATES.HOLDING:
				var current_pos = event.position / Core.CANVAS_AMPLIFICATION
				if last_point.distance_to(current_pos) > 1:
					canvas.draw_line_on_canvas(last_point, current_pos, Color.TRANSPARENT)
					last_point = event.position / Core.CANVAS_AMPLIFICATION
			_:
				pass


	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			last_point = event.position / Core.CANVAS_AMPLIFICATION
			canvas.draw_point_on_canvas(last_point, Color.TRANSPARENT)
			drawing_state = int(event.pressed)

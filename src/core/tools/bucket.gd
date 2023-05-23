extends Tool

const ACTION:PackedScene = preload("res://res/components/actions/brush_action.tscn")


func _init():
	super()
	tool_name = "Bucket"
	tool_icon = load("res://res/textures/icons/paint_bucket_spilling-16x.png")


func _actionbar_init(action_bar:PanelContainer):
	action_bar.set_action(ACTION)


var last_point:Vector2 = Vector2.ONE
func _canvas_input(canvas:Canvas, event:InputEvent):
	if event is InputEventMouseButton:
		if event.button_index in [MOUSE_BUTTON_LEFT, MOUSE_BUTTON_RIGHT]:
			if event.pressed:
				var color = current_workspace.get_primary_color() if event.button_index == 1 else current_workspace.get_secondary_color()
				canvas.draw_flood_fill_on_canvas(round(event.position / Core.CANVAS_AMPLIFICATION), color)

extends BoxContainer

var canvas:Canvas
var cur_tool:Tool


func _ready():
	child_entered_tree.connect(_on_new_canvas)
	CoreTools.tool_selected.connect(_on_selection)


func _on_new_canvas(child):
	if child is Canvas:
		canvas = child
		if CoreTools.current_tool:
			cur_tool = CoreTools.current_tool
		canvas.gui_input.connect(_on_input)
		

func _on_selection(tool):
	cur_tool = tool


func _on_input(event):
	if cur_tool:
		cur_tool._canvas_input(canvas, event)

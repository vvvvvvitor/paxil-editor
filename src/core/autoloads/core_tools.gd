extends Node

signal tool_selected


const TOOLS_PRELOADS:Array[GDScript] = [
	preload("res://src/core/tools/brush.gd"),
	preload("res://src/core/tools/eraser.gd"),
	preload("res://src/core/tools/bucket.gd"),
]
var tools = []
var current_tool:Tool


func _ready():
	await Core.workspace_changed
	tool_selected.connect(_on_selection)
	for tool in TOOLS_PRELOADS:
		var new_tool = tool.new()
		tools.append(new_tool)


func get_tool_from_index(index:int) -> Tool:
	return tools[index]


func _on_selection(tool):
	current_tool = tool

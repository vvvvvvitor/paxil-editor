extends Node
class_name Tool

var tool_name:StringName
var tool_icon:CompressedTexture2D = Core.DEFAULT_ICON

var current_workspace:WorkspaceViewport


func _init():
	current_workspace = Core.current_workspace


func _on_selection():
	pass


func _actionbar_init(toolbar:PanelContainer):
	pass


func _canvas_input(canvas:Canvas, event:InputEvent):
	pass

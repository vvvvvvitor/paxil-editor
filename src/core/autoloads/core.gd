extends Node

signal tool_changed

const DEFAULT_ICON = preload("res://res/textures/icons/broken_file.png")
const CANVAS_AMPLIFICATION:int = 16

var current_workspace:WorkspaceViewport


func create_window_popup(scene:PackedScene, custom_size:Vector2 = Vector2(384, 384), on_top:bool = true) -> BaseWindow:
	var new_window = BaseWindow.create_with_size(custom_size.x, custom_size.y, 288, 288)
	var scene_instance = scene.instantiate()
	
	new_window.exclusive = true
	new_window.always_on_top = on_top
	new_window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	
	new_window.add_child(scene_instance)
	add_child(new_window)
	
	new_window.show()
	
	return new_window

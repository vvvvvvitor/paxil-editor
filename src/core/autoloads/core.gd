extends Node

signal tool_changed

const DEFAULT_ICON = preload("res://res/textures/icons/broken_file.png")
const CANVAS_AMPLIFICATION:int = 16

var current_workspace:WorkspaceViewport

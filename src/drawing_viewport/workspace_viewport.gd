extends SubViewport
class_name WorkspaceViewport

signal tool_changed

const WORKSPACE_SCENE = preload("res://res/components/workspace.tscn")
var workspace = WORKSPACE_SCENE.instantiate()

@export var brush_color:Color = Color.BLACK


# Called when the node enters the scene tree for the first time.
func _ready():
	Core.current_workspace = self
	
	var workspace_camera = WorkspaceCamera.new()
	workspace_camera.ignore_rotation = false
	add_child(workspace_camera)
	add_child(workspace)

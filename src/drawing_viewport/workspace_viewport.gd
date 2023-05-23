extends SubViewport
class_name WorkspaceViewport

signal tool_changed
signal workspace_created

const WORKSPACE_SCENE = preload("res://res/components/workspace.tscn")
var workspace = WORKSPACE_SCENE.instantiate()

@export var brush_color:Color = Color.BLACK

var color_pallete:PackedColorArray = []

var primary_color:int = 0
var secondary_color:int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Core.current_workspace = self
	
	var workspace_camera = WorkspaceCamera.new()
	workspace_camera.ignore_rotation = false
	add_child(workspace_camera)
	add_child(workspace)
	emit_signal("workspace_created")


func get_pallete_color(index):
	if !color_pallete.is_empty():
		return color_pallete[index] * ceil(color_pallete[index].a)
	return Color.BLACK
	
	
func get_primary_color():
	return get_pallete_color(primary_color)


func get_secondary_color():
	return get_pallete_color(secondary_color)


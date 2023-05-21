extends Node2D


var snapping_vector:Vector2 = Vector2.ONE

var primary_color:Color
var secondary_color:Color


func get_canvas_manager() -> CanvasManager:
	for child in get_children():
		if child is CanvasManager:
			return child
	return

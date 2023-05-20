extends Node


func get_rect_local_size(rect:Rect2) -> Vector2:
	return Vector2(
		(rect.position.x - rect.size.x),
		(rect.position.y - rect.size.y)
	)

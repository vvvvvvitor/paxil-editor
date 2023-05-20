extends Node2D


func _draw():
	draw_line(Vector2.ZERO, Vector2.UP * 16, Color.BLUE)
	draw_line(Vector2.ZERO, Vector2.LEFT * 16, Color.RED)

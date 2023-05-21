extends TextureRect
class_name Canvas

signal canvas_focused

enum COLOR_MODE {
	NORMAL,
	ADDITIVE
}


var image_buffer:Image
var image_texture:ImageTexture
var workspace:WorkspaceViewport = Core.current_workspace
var _cursor_position:Vector2 = Vector2.ZERO


static func create_canvas(width:int, height:int):
	var canvas = Canvas.new()
	canvas.image_buffer = Image.create(abs(width), abs(height), false, Image.FORMAT_RGBAF)
	canvas.image_texture = ImageTexture.create_from_image(canvas.image_buffer)
	
	canvas.texture = canvas.image_texture
	return canvas


# Called when the node enters the scene tree for the first time.
func _ready():
	if !image_buffer:
		image_buffer = Image.create(128, 128, false, Image.FORMAT_RGBAF)
		image_texture = ImageTexture.create_from_image(image_buffer)

		image_texture.update(image_buffer)
		texture = image_texture
	image_texture.update(image_buffer)
	#draw_flood_fill_on_canvas(Vector2.ZERO, Color.BLACK)


func draw_point_on_canvas(pos:Vector2, color:Color, color_mode:COLOR_MODE = COLOR_MODE.NORMAL):
	match color_mode:
		COLOR_MODE.NORMAL:
			image_buffer.set_pixel(pos.x, pos.y, color)
		COLOR_MODE.ADDITIVE:
			var prev_color = image_buffer.get_pixel(pos.x, pos.y)
			image_buffer.set_pixel(pos.x, pos.y, prev_color + color)
	image_texture.update(image_buffer)


func draw_line_on_canvas(initial_position:Vector2, ending_position:Vector2, color:Color, color_mode:COLOR_MODE = COLOR_MODE.NORMAL):
	var dist = initial_position.distance_to(ending_position)
	for point in dist:
		draw_point_on_canvas(lerp(initial_position, ending_position, point / dist), color, color_mode)

 
func draw_flood_fill_on_canvas(initial_position:Vector2, color:Color):
	var canvas_size = Vector2(image_buffer.get_size())
	var old_color = image_buffer.get_pixelv(initial_position)
	
	if old_color == color:
		return
	var queue:PackedVector2Array = []
	queue.append(initial_position)
	
	while !queue.is_empty():
		var next_pos = queue[0]
		queue.remove_at(0)
		
		if (next_pos.x < 0 or next_pos.x >= canvas_size.x) or (next_pos.y < 0 or next_pos.y >= canvas_size.y) or image_buffer.get_pixelv(next_pos) != old_color:
			continue
		else:
			draw_point_on_canvas(next_pos, color)
			
			queue.append(next_pos + Vector2.LEFT)
			queue.append(next_pos + Vector2.RIGHT)
			queue.append(next_pos + Vector2.UP)
			queue.append(next_pos + Vector2.DOWN)


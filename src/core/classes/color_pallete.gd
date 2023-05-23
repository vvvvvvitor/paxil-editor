extends HBoxContainer
class_name ColorPallete

signal color_changed
signal color_added
signal primary_changed
signal secondary_changed

@export var __colors:PackedColorArray
@export var primary_color:int = 0:
	set(val):
		primary_color = val
		emit_signal("primary_changed", primary_color)
@export var secondary_color:int = 0:
	set(val):
		secondary_color = val
		emit_signal("secondary_changed", secondary_color)


func _enter_tree():
	make_pallete()


# I don't like this but it works
func _process(delta):
	queue_redraw()


func _draw():
	if get_child_count() > secondary_color:
		draw_arc(get_children()[secondary_color].position, 6, 0, TAU, 16, Color.WHITE)
	if get_child_count() > primary_color:
		draw_circle(get_children()[primary_color].position, 4, Color.WHITE)


func make_pallete(): # OPTIMIZE THIS LATER !!!
	if !__colors.is_empty():
		for index in range(__colors.size()):
			if get_child(index):
				if get_children()[index].color == __colors[index]:
					continue
				continue
			else:
				var new_button = ColorPickerPreviewButton.new()
				new_button.button_mask = MOUSE_BUTTON_MASK_MIDDLE
				new_button.color = __colors[index]
				new_button.modulate = new_button.color
				new_button.color_pressed.connect(__on_color_pressed)
				new_button.color_accepted.connect(__on_accept)
				new_button.set_meta("color_id", index)
				add_child(new_button)


func set_color(index, color):
	__colors[index] = color
	emit_signal("color_changed", index, color)


func add_color(color):
	__colors.append(color)
	make_pallete()
	emit_signal("color_added", color)
	

func remove_color(index):
	__colors.remove_at(index)
	get_children()[index].queue_free()
	make_pallete()


func get_color(index) -> Color:
	return __colors[index]


func get_pallete() -> PackedColorArray:
	return __colors
	
	
func set_pallete(new_pallete:PackedColorArray):
	__colors = new_pallete


func __on_accept(node, color):
	set_color(node.get_meta("color_id"), color)


func __on_color_pressed(node, press):
	var color_id = node.get_meta("color_id")
	if press == MOUSE_BUTTON_LEFT:
		primary_color = color_id
	elif press == MOUSE_BUTTON_RIGHT:
		secondary_color = color_id

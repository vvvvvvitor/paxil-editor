shader_type canvas_item;

uniform vec4 color:source_color;

void fragment() {
	COLOR = vec4(UV.x * color.r, UV.x * color.g, (UV.x / (1.0 - UV.y)) * color.b, 1);
}

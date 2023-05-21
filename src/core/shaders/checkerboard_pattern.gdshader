shader_type canvas_item;


uniform float cells = 8.0; // how many cells in checkerboard pattern
uniform vec3 color1: source_color;
uniform vec3 color2: source_color;

void fragment() { // assign color by even/odd checkerboard pattern
	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 scaled_uv = (SCREEN_UV - vec2(0.5, 0.2)) / vec2(ratio, 1.0) + vec2(0.5, 0.0);
	
	bool cell = (mod(floor(scaled_uv.x * cells) + floor(scaled_uv.y * cells), 2.0) == 0.0);
	COLOR = vec4(vec3(cell ? color1 : color2), 1.0);
}
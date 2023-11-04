shader_type canvas_item;


global uniform vec4 base;
global uniform vec4 font;


const vec4 BASE = vec4(0.0, 0.0, 0.0, 1.0);
const vec4 FONT = vec4(1.0, 1.0, 1.0, 1.0);


void fragment() {
	float d_to_base = length(COLOR - BASE);
	float d_to_font = length(COLOR - FONT);
	if (COLOR != vec4(0.0)) {
		float compare;
		vec4 g;
		if (d_to_base < d_to_font) {
			compare = d_to_base;
			g = base;
		} else {
			compare = d_to_font;
			g = font;
		}
		COLOR = g;
		COLOR.a = 1.0 - compare;
	}
}

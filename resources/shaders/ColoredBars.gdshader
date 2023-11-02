shader_type canvas_item;

uniform vec4 c1: source_color;
uniform vec4 c2: source_color;

uniform float d = 0.2;
uniform float angle = 1.7;
uniform float time_scale = 0.1;
uniform float show = 2.0;


float fmod(float x, float y) {
	return x - floor(x / y) * y;
}


void fragment() {
	float two_d = 2.0 * d;
	float d_to_line = abs(UV.x * tan(angle) - UV.y) / sqrt(pow(tan(angle), 2) + 1.0);
	
	if (fmod(d_to_line - time_scale * TIME, two_d) < d) {
		COLOR = c1;
	} else {
		COLOR = c2;
	}
	
	if (d_to_line > show) {
		COLOR.a = 0.0;
	}
}
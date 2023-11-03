shader_type canvas_item;

uniform float radius = 0.5;

void fragment() {
	float d = sqrt(pow(UV.x - radius, 2.0) + pow(UV.y - radius, 2.0));
	if (d > radius) {
		COLOR = vec4(0.0);
	}
}

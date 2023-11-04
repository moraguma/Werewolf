shader_type canvas_item;

uniform vec4 bottom_color: source_color;
uniform vec4 top_color: source_color;

uniform float ray_distance = 0.02;
uniform float ray_width = 0.015;
uniform float ray_length = 0.3;
uniform float ray_spacing = 0.5;
uniform float time_scale = 1.0;
uniform float level_time_diff = 0.05;

uniform int total_phases: hint_range(2, 600, 1);


float fmod(float x, float y) {
	return x - floor(x / y) * y;
}


vec4 lerp(vec4 a, vec4 b, float w) {
	return a + w * (b - a);
}


bool is_valid_x(float x, float y, float time_mod) {
	float r = ray_width / 2.0;
	float extra_x = sqrt(pow(r, 2.0) - pow(abs(y - r), 2.0));
	
	float total_spacing = ray_length + ray_spacing;
	float center = fmod(TIME * time_scale * time_mod, total_spacing);
	float left_limit = center - ray_length / 2.0 - extra_x;
	float right_limit = center + ray_length / 2.0 + extra_x;
	
	float m = fmod(x, total_spacing);
	return m >= left_limit && m <= right_limit || m >= left_limit + total_spacing || m <= right_limit - total_spacing;;
}


void fragment() {
	float diff = 1.0 / float(total_phases);
	float lower_border = diff + ray_distance + ray_width;
	float upper_border = diff + ray_distance;
	float y = UV.y;
	
	for (int i = 0; i < total_phases; i++) {
		if (y <= diff || y <= lower_border && y >= upper_border && is_valid_x(UV.x, y - diff - ray_distance, 1.0 + float(i) * level_time_diff)) {
			COLOR = lerp(bottom_color, top_color, float(i) * diff);
			break;
		}
		y -= diff;
	}
}
shader_type canvas_item;

const float TWO_PI = 6.28318530718;
const float SCALE = 4.;

uniform int n = 3;
// New uniform for rotation in degrees
uniform float rotation_degrees = 0.0; 

float polygon(vec2 uv, float width, int sides, float rotation_rad)
{
	uv = uv * SCALE - (SCALE / 2.);

	// Add the rotation (in radians) to the calculated angle
	float angle = atan(uv.x, uv.y) + rotation_rad;
	float radius = TWO_PI / float(sides);

	float dist = cos(floor(0.5 + angle / radius) * radius - angle) * length(uv);
	float poly = step(width, dist);
	return poly;
}

void fragment() {
	// Convert the degrees uniform to radians once
	float rotation_rad = radians(rotation_degrees);
	
	// Pass the rotation in radians to the polygon function
	float poly = polygon(UV, 0.95, n, rotation_rad);
	
	COLOR = vec4(COLOR.rgb, 1.0-poly);
}
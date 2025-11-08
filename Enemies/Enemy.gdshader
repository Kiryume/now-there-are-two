shader_type canvas_item;

const float TWO_PI = 6.28318530718;
const float SCALE = 4.;
uniform int n = 3;

float polygon(vec2 uv, float width, int sides)
{
    uv = uv * SCALE - (SCALE / 2.);

    float angle = atan(uv.x, uv.y);
    float radius = TWO_PI / float(sides);

    float dist = cos(floor(0.5 + angle / radius) * radius - angle) * length(uv);
    float poly = step(width, dist);
    return poly;
}

void fragment() {
    float poly = polygon(UV, 0.95, n);
	COLOR = vec4(COLOR.rgb, 1.0-poly);
}
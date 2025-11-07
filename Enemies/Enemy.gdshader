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
    // Example usage: draw a hexagon (6 sides) with thin stroke
    float poly = polygon(UV, 0.95, n);
	COLOR = vec4(COLOR.rgb, 1.0-poly);

    // You can modify the parameters:
    // - Change the last parameter (6) to any integer for different polygons
    // - Adjust the second parameter (0.95) to control thickness (closer to 1.0 = thinner)
}
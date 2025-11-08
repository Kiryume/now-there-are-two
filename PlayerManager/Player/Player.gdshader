// Set the shader type to canvas_item for 2D.
shader_type canvas_item;

// 'uniform' variables can be edited from the Godot Inspector.
uniform float radius : hint_range(0.0, 0.5) = 0.5;
uniform float softness : hint_range(0.0, 0.1) = 0.001;

void fragment() {
    // UV coordinates go from (0,0) at the top-left to (1,1) at the bottom-right.
    // We remap them so (0,0) is at the center of the texture.
    vec2 center_uv = UV - 0.5;

    // Calculate the distance of the current pixel from the center.
    float dist = length(center_uv);

    // smoothstep() creates a soft edge.
    // It returns 0.0 if 'dist' is >= 'radius'.
    // It returns 1.0 if 'dist' is <= 'radius' - 'softness'.
    // It interpolates between 0.0 and 1.0 for values in between.
    float alpha = smoothstep(radius, radius - softness, dist);

    // Set the final color.
    // The circle's color is 'circle_color', and its alpha is 'alpha'.
    COLOR = vec4(COLOR.rgb, alpha);
}
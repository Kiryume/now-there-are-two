shader_type canvas_item;
render_mode world_vertex_coords; // This is the key - makes VERTEX represent world coordinates

// Noise texture for star field
uniform sampler2D noise_texture;
// Scale factor for the noise (higher = more stars)
uniform float noise_scale = 100.0;
// Threshold for determining which noise values become visible stars
uniform float star_threshold = 0.8;
// Star brightness
uniform float star_brightness = 1.0;

void fragment() {
    // VERTEX now contains world coordinates thanks to world_vertex_coords render mode
    vec2 world_pos = VERTEX;

    // Sample the noise texture at the world position, scaled appropriately
    float noise = texture(noise_texture, world_pos / noise_scale).r;

    // Create stars by making pixels brighter where noise exceeds threshold
    float star = step(star_threshold, noise) * star_brightness;

    // Output black background with white stars
    COLOR = vec4(vec3(star), 1.0);
}

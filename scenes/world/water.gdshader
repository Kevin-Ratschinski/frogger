shader_type canvas_item;


uniform float wave_strength = 3.0;
uniform float wave_speed = 1.5;
uniform float wave_frequency = 10.0;
uniform float blue_threshold = 0.5;

void fragment() {
    vec2 uv = UV;
    vec4 tex_color = texture(TEXTURE, uv);
    bool is_blue = tex_color.b > blue_threshold && tex_color.b > tex_color.r && tex_color.b > tex_color.g;
    
    if (is_blue) {
		float wave1 = sin(uv.x * wave_frequency + TIME * wave_speed);
		float wave2 = cos(uv.y * wave_frequency * 0.8 + TIME * wave_speed * 1.2);
		uv.y += (wave1 + wave2) * wave_strength / 200.0;
    }

    COLOR = texture(TEXTURE, uv);
}
shader_type canvas_item;

uniform float alpha : hint_range(0,1) = 0.1;
uniform vec3 color = vec3(0.1, 0.5, 0.9);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = vec4(color, tex_color.a * alpha);
}
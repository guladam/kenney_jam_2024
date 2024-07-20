shader_type canvas_item;

void fragment () {
	COLOR = vec4(0.7, 0.0, 0.0, texture(TEXTURE, UV).a);
}
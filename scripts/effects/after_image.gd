extends Sprite2D

@export var fade_time := 0.3
var elapsed := 0.0

func _process(delta):
	elapsed += delta
	if material and material is ShaderMaterial:
		material.set_shader_parameter("alpha", lerp(1.0, 0.0, elapsed / fade_time))
	if elapsed >= fade_time:
		queue_free()

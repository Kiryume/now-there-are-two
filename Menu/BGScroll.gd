extends ColorRect

@export var speed := .1;

@export var offset := 0.;

func _process(delta: float) -> void:
	offset += speed * delta
	self.material.set("shader_parameter/offset", Vector2(0, offset))

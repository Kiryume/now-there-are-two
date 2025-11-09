extends Node2D

func _ready() -> void:
	var root = get_tree().root.get_child(0)
	if not root: return
	for child in root.get_children():
		if child is GPUParticles2D or child is Drop:
			root.remove_child(child)

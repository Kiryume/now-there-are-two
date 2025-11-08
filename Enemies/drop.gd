extends Area2D
class_name Drop

@export var xp_value = 1.

@onready var rect = $Rect

func _ready():
	rect.color *= 3

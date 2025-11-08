extends AnimatableBody2D

var offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	offset = position

func _physics_process(_delta):
	global_position = get_parent().global_position + offset

func _process(_delta):	
	global_position = get_parent().global_position + offset

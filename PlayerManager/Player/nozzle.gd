extends Marker2D
class_name Nozzle

@export
var bullet_scene: PackedScene
@export 
var bullet_speed_modifier := 1.
@onready
var parent = get_parent()
@onready
var shoot_player = $"../Shoot"
@export
var color: Color

func _ready():
	parent.on_shoot.connect(shoot)

func shoot() -> void:
	var child: BaseProjectile = bullet_scene.instantiate() as BaseProjectile
	child.projectile_speed *= bullet_speed_modifier
	child.shooter = parent.owner
	var root = get_tree().root.get_child(0)
	root.add_child(child)
	child.transform = global_transform
	child.text.color = color
	shoot_player.play()

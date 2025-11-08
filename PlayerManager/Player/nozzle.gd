extends Marker2D
class_name Nozzle

@export
var bullet_scene: PackedScene
@onready
var parent = get_parent()

func _ready():
	(parent as WeaponController).on_shoot.connect(shoot)

func shoot() -> void:
	var child: BaseProjectile = bullet_scene.instantiate() as BaseProjectile
	child.shooter = parent.owner
	var root = get_tree().root.get_child(0)
	root.add_child(child)
	child.transform = global_transform
	child.text.color = (parent.owner as Player).target_color * 2

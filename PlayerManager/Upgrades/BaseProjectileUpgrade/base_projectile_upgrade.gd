extends Upgrade

var target_node: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _init() -> void:
	upgrade_name = "Base Projectile"
	target = Target.Player

func on_attach(node: Player):
	target_node = node

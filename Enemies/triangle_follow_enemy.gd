extends Enemy
@onready var hurtbox: Hurtbox = $Hurtbox
var droptscn = preload("res://Enemies/Drop.tscn")

func _ready():
	super._ready()
	hurtbox.hurt.connect(_on_hurt)

func _physics_process(delta: float) -> void:
	move_to_nearest_player(delta)

func die():
	var drop = droptscn.instantiate()
	call_deferred("add_drop", drop, global_position)
	queue_free()

func add_drop(drop: Drop, new_position: Vector2):
	get_tree().root.get_child(0).add_child(drop)
	drop.global_position = new_position
	
func _on_hurt(damage_profile: DamageResource):
	take_dmg(damage_profile.amount)

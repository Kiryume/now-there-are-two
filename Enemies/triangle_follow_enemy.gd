extends Enemy
@export var xp_value = 1.
@onready var hurtbox: Hurtbox = $Hurtbox
var droptscn = preload("res://Enemies/Drop.tscn")
var deathparticle = preload("res://Enemies/yellow_enemy_death_anim.tscn")

func _ready():
	super._ready()
	hurtbox.hurt.connect(_on_hurt)

func _physics_process(delta: float) -> void:
	move_to_nearest_player(delta)

func die():
	var drop = droptscn.instantiate()
	var particles = deathparticle.instantiate()
	call_deferred("add_drop", drop, particles, global_position)
	queue_free()

func add_drop(drop: Drop, particles: GPUParticles2D, new_position: Vector2):
	if DirectDeposit.get_instance().rand_chance():
		UpgradeDB.gain_xp(xp_value)
	else:
		get_tree().root.get_child(0).add_child(drop)
		drop.xp_value = xp_value
		drop.global_position = new_position
	get_tree().root.get_child(0).add_child(particles)
	particles.global_position = new_position
	particles.emitting = true
	
func _on_hurt(damage_profile: DamageResource):
	take_dmg(damage_profile.amount)

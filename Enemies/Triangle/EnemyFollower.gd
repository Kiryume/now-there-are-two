extends Enemy

@export var level = 1
const max_level = 5

@export var xp_value = 1.
@onready var hurtbox: Hurtbox = $Hurtbox
var droptscn = preload("res://Enemies/Drop.tscn")
var deathparticle = preload("res://Enemies/EnemyDeathAnimation.tscn")

func get_xp_value():
	return level
	
func get_max_hp_value():
	return level * 10
	
func get_color():
	var base_color = Color.YELLOW*1.15
	var full_color = Color.RED*1.5
	return lerp(base_color, full_color, (level - 1) / 4.)

func _ready():
	super._ready()
	level = clamp(level, 1, max_level)
	hurtbox.hurt.connect(_on_hurt)
	max_health = get_max_hp_value()
	health = max_health
	color = get_color()
	update_color()

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

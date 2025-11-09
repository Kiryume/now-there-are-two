extends Enemy

@export var level = 1
const max_level = 20

@onready var hurtbox: Hurtbox = $Hurtbox
var droptscn = preload("res://Enemies/Drop.tscn")
var deathparticle = preload("res://Enemies/EnemyDeathAnimation.tscn")

@onready var nozzle = $MainNozzle
@onready var timer = $ShootTimer

func get_xp_value():
	return level * 3
	
func get_max_hp_value():
	return level * 10
	
func get_bullet_speed():
	return lerp(0.25, 0.6, level / (max_level as float))

func get_shoot_timer():
	return lerp(3.0, 1., level/(max_level as float))
	
func get_color():
	var base_color = Color.YELLOW*1.15
	var full_color = Color.RED*1.5
	return lerp(base_color, full_color, (level - 1) / max_level)

func update_color():
	super.update_color()
	nozzle.color = color

func _ready():
	super._ready()
	level = clamp(level, 1, max_level)
	hurtbox.hurt.connect(_on_hurt)
	max_health = get_max_hp_value()
	health = max_health
	color = get_color()
	update_color()
	nozzle.bullet_speed_modifier = get_bullet_speed()
	timer.wait_time = get_shoot_timer()

func _physics_process(delta: float) -> void:
	var closest_player := get_closest_player()
	if not closest_player:
		return
	var direction = closest_player.position - position
	var target_angle = direction.angle()
	rotation = lerp_angle(rotation, target_angle, delta * rotation_speed)
	if direction.length() < 500:
		direction = Vector2(-direction.x, direction.y)
	velocity = direction.normalized() * speed
	move_and_slide()

func die():
	var drop = droptscn.instantiate()
	var particles = deathparticle.instantiate()
	call_deferred("add_drop", drop, particles, global_position)
	queue_free()

func add_drop(drop: Drop, particles: GPUParticles2D, new_position: Vector2):
	var xp_value = get_xp_value()
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

signal on_shoot

func _on_shoot_timer_timeout() -> void:
	on_shoot.emit()

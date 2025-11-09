@tool
extends Resource
class_name DamageResource
enum DamageType {
	Kinetic,
	Energy,
	Tick
}

@export var amount: float = 10.0
@export var damage_type: DamageType = DamageType.Kinetic
@export var tick_rate: float = 0.5

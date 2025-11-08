@tool
extends Resource
class_name DamageResource
enum DamageType {
	Kinetic,
	Energy
}

@export var amount: float = 10.0
@export var damage_type: DamageType = DamageType.Kinetic

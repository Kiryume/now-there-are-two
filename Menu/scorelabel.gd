extends Label

var base_text = "Killed enemies: %s
Total score: %s"

func _ready() -> void:
	text = (base_text
		% [UpgradeDB.total_enemies,UpgradeDB.total_xp]
	)
	

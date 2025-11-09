extends Label

var base_text = "Killed enemies: %d
Total score: %d"

func _ready() -> void:
	text = (base_text
		% [UpgradeDB.total_enemies,UpgradeDB.total_xp]
	)
	

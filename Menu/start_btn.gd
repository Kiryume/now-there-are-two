extends Button

const main_scene: PackedScene = preload("res://main.tscn")

func _on_pressed() -> void:
	UpgradeDB.reset()
	get_tree().change_scene_to_packed(main_scene)

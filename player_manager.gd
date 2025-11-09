extends Node2D
class_name PlayerManager

@onready
var player1: Player = $Player
@onready
var player2: Player = $Player2
var end_scene: PackedScene = load("res://Menu/Score.tscn") 

func _ready():
	PlayerList.set_players([player1, player2])
	PlayerList.player_died.connect(_on_player_died)
	$ReviveTimer.timeout.connect(_revive_player)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("swap_sides"):
		if not $ReviveTimer.is_stopped():
			return
		PlayerList.players_swapped.emit(player1.global_position, player2.global_position)
		var temp = player1.player_select
		player1.player_select = player2.player_select
		player2.player_select = temp

func _on_player_died(which: String):
	if not $ReviveTimer.is_stopped():
		get_tree().change_scene_to_packed(end_scene)
		return
	$ReviveTimer.start()
	
func _revive_player():
	var dead_player : Player
	var live_player : Player
	if not player1.visible:
		dead_player = player1
		live_player = player2
	else:
		dead_player = player2
		live_player = player1
	dead_player.revive(live_player.position)

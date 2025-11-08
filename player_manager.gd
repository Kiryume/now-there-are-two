extends Node2D
class_name PlayerManager

@onready
var player1: Player = $Player
@onready
var player2: Player = $Player2

func _ready():
	PlayerList.set_players([player1, player2])

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("swap_sides"):   
		PlayerList.players_swapped.emit(player1.global_position, player2.global_position)
		var temp = player1.player_select
		player1.player_select = player2.player_select
		player2.player_select = temp

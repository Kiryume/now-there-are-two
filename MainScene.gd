extends Node2D

@onready
var players: Array[Player] = [$Player, $Player2]

func _ready():
	PlayerList.set_players(players)

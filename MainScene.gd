extends Node2D

@onready
var players: Array[Player] = [$PlayerManager/Player, $PlayerManager/Player2]

func _ready():
	PlayerList.set_players(players)

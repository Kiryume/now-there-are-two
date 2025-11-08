extends Node2D

@onready
var players: Array[Player] = [$PlayerManager/Player, $PlayerManager/Player2]

var health = 100.

func _ready():
	PlayerList.set_players(players)

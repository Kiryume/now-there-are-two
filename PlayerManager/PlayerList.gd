extends Node

var players: Array[Player]

func set_players(new_players: Array[Player]):
	players = new_players

func get_center() -> Vector2:
	var p = Vector2.ZERO
	var size = 0
	for target in players:
		if not target.visible:
			continue
		p += target.position
		size += 1
	p /= size
	return p

signal players_swapped(pos1: Vector2, pos2: Vector2)
signal players_collided
signal player_died(which: String)

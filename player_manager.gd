extends Node2D


@onready
var player1: Player = $Player
@onready
var player2: Player = $Player2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("swap_sides"):        
		var temp = player1.player_select
		player1.player_select = player2.player_select
		player2.player_select = temp
		

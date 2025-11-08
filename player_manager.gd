extends Node2D


@onready
var player1: Player = $UpgradeManager/Player
@onready
var player2: Player = $UpgradeManager/Player2

func _ready():
	PlayerList.set_players([player1, player2])

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("swap_sides"):   
		emit_signal("player_swapped")
		var temp = player1.player_select
		player1.player_select = player2.player_select
		player2.player_select = temp
		

signal player_swapped

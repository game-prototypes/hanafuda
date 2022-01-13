extends Node2D

onready var points_counter=$CanvasLayer/RoundSummary

export(bool) var end_game=false

func _ready():
	var player1=PlayerInfo.new(1,{
		"type": Constants.PlayerType.HUMAN
	})
	var player2=PlayerInfo.new(10,{
		"type": Constants.PlayerType.HUMAN
	})
	
	player1.add_round_points(10)
	player1.add_round_points(0)
	player1.add_round_points(0)
	
	player2.add_round_points(0)
	player2.add_round_points(0)
	player2.add_round_points(6)
	
	points_counter.set_round(2)

	if end_game:
		for i in range(9):
			player1.add_round_points(1)
			player2.add_round_points(0)
			points_counter.set_round(12)
			points_counter.show_winner(player1)
	
	points_counter.fill_table([player1, player2])
	points_counter.show_modal()

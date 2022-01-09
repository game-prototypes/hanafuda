extends Node2D

onready var points_counter=$CanvasLayer/PointCounter


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
	
	points_counter.fill_table([player1, player2])

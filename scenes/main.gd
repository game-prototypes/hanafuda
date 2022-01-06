extends Node2D

var Dealer = preload("res://scripts/dealer.gd")

onready var deck:Deck=$Deck
onready var table:CardStack=$Table

var dealer


var players=[]

func _enter_tree():
	randomize()

func _ready():
	players=get_tree().get_nodes_in_group("player")
	for player in players:
		player.game_setup(table, deck)
		player.connect("turn_finished", self, "_on_player_turn_finished")

	dealer=Dealer.new(deck)
	dealer.deal(players[0], players[1], table)
	_begin_player_turn(0)

func _begin_player_turn(index:int):
	prints("Player", index, "Turn")
	players[index].begin_turn()

func _on_player_turn_finished(player, round_end: bool):
	var index=players.find(player)
	assert(index!=-1, "Player not found")
	index+=1
	if index==players.size():
		index=0
	_begin_player_turn(index)
	
	# TODO: check round_end and if both players do not have cards (tie)

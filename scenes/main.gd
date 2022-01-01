extends Node2D

var Dealer = preload("res://scripts/dealer.gd")

onready var deck:Deck=$Deck
onready var player_stack:CardStack=$HumanPlayer/PlayerStack # TODO: deal to player instead
onready var oponent_stack:CardStack=$OponentStack
onready var table:CardStack=$Table

var dealer


var players=[]

func _enter_tree():
	randomize()

func _ready():
	players=get_tree().get_nodes_in_group("player")
	for player in players:
		player.table=table
		player.deck=deck
		player.connect("turn_finished", self, "_on_player_turn_finished")

	dealer=Dealer.new(deck)
	dealer.deal(player_stack, oponent_stack, table)
	_begin_player_turn(0)
		
	

func _begin_player_turn(index:int):
	prints("Player", index, "Turn")
	players[index].begin_turn()

func _on_player_turn_finished(player):
	var index=players.find(player)
	assert(index!=-1, "Player not found")
	index+=1
	if index==players.size():
		index=0
	_begin_player_turn(index)

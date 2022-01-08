extends Node2D

var Dealer = preload("res://scripts/dealer.gd")

onready var deck:Deck=$Deck
onready var table:CardStack=$Table

var dealer
var koi_koi: bool = false

var players=[]

func _enter_tree():
	randomize()

func _ready():
	players=get_tree().get_nodes_in_group("player")
	for player in players:
		player.game_setup(table, deck)
		player.connect("turn_finished", self, "_on_player_turn_finished")
		player.connect("koi_koi", self, "_on_koikoi")

	dealer=Dealer.new(deck)
	dealer.deal(players[0], players[1], table)
	_begin_player_turn(0)

func _begin_player_turn(index:int):
	prints("Player", index, "Turn")
	players[index].begin_turn()

func _on_koikoi():
	koi_koi=true
	
func _on_player_turn_finished(player, round_end: bool):
	var index=players.find(player)
	assert(index!=-1, "Player not found")
	if round_end:
		end_round(player)
	elif no_cards_left_in_players():
		end_round()
	else:
		index+=1
		if index==players.size():
			index=0
		_begin_player_turn(index)

func end_round(winner=null):
	print("ROUND END")
	
	if winner == null:
		print("TIE")
	else:
		prints("Player",winner,"wins")
	

func no_cards_left_in_players()->bool:
	for player in players:
		if player.hand_cards_count()==0:
			return true
	return false

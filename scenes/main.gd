extends Node2D

var Dealer = preload("res://scripts/dealer.gd")

onready var deck:Deck=$Deck
onready var player_stack:CardStack=$Player/PlayerStack
onready var oponent_stack:CardStack=$OponentStack
onready var table:CardStack=$Table

var dealer

signal next_turn(turn)
signal next_phase(phase, turn)


func _enter_tree():
	randomize()

func _ready():
	$Player.table=table
	dealer=Dealer.new(deck)
	dealer.deal(player_stack, oponent_stack, table)


# TODO: Move Gameplay loop to a separate node/class

func next_phase():
	if Global.is_last_phase():
		var turn=Global.next_turn()
		emit_signal("next_turn",turn)
	else:
		var phase=Global.next_phase()
		emit_signal("next_phase", Global.turn, phase)
	return Global.phase
		
	

func _on_player_cards_captured(player):
	var phase=next_phase()
	player.on_new_phase(phase)
	if phase==Global.TurnPhase.DeckMatching:
		var card = dealer.take_card()
		player.set_deck_card(card)

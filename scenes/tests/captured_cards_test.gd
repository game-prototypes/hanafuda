extends Node2D

var Dealer = preload("res://scripts/dealer.gd")

func _ready():
	randomize()
	var deck=$Deck
	deck.reset()
	deck.shuffle()
	var dealer=Dealer.new(deck)
	dealer.deal_cards_to_stack($CapturedCards, 15)
	

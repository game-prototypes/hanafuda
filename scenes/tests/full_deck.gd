extends Node2D

var Dealer = preload("res://scripts/dealer.gd")


func _ready():
	var deck=$Deck
	deck.reset()
	Dealer.deal_cards_to_stack(deck, $CardStack, deck.size())
	

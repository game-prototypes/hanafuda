extends Node2D

var Dealer = preload("res://scripts/dealer.gd")


func _ready():
	var deck=$Deck
	deck.reset()	
	var dealer=Dealer.new(deck)
	dealer.deal_cards_to_stack($CardStack, deck.size())
	

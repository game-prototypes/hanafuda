extends Node2D

onready var deck:Deck=$Deck
onready var player_stack:CardStack=$PlayerStack

func _enter_tree():
	randomize()

func _ready():
	var card=deck.get_card()
	player_stack.add_card(card)
	var card2=deck.get_card()
	player_stack.add_card(card2)

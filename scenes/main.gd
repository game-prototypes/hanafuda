extends Node2D

onready var deck:Deck=$Deck
onready var player_stack:CardStack=$PlayerStack

func _ready():
	var card=deck.get_card()
	player_stack.add_card(card)

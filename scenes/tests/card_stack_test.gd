extends Node2D

onready var deck:Deck = $Deck
onready var card_stack:CardStack=$CardStack

# Called when the node enters the scene tree for the first time.
func _ready():
	deck.reset()
	deal_card()
	var second_card=deal_card()
	deal_card()
	card_stack.remove_card(second_card)


func deal_card():
	var card=deck.take_card()
	card_stack.add_card(card)
	return card

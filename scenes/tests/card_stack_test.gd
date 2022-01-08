extends Node2D

onready var deck:Deck = $Deck
onready var card_stack1:CardStack=$CardStack1
onready var card_stack2:CardStack=$CardStack2

# Called when the node enters the scene tree for the first time.
func _ready():
	deck.reset()
	deal_card()
	var second_card=deal_card()
	deal_card()
	card_stack1.remove_card(second_card)
	card_stack2.add_card(second_card)


func deal_card():
	var card=deck.take_card()
	card_stack1.add_card(card)
	return card

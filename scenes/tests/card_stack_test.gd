extends Node2D

onready var deck:Deck = $Deck
onready var table:CardStack=$Table
onready var hand:CardStack=$Hand

func _ready():
	deck.reset()

func _on_add_card_to_hand():
	var card=deck.take_card()
	hand.add_card(card)


func _on_add_card_to_table():
	var card=deck.take_card()
	table.add_card(card)


func _on_table_card_selected(card):
	table.remove_card(card)
	card.queue_free()

func _on_hand_card_selected(card):
	hand.remove_card(card)
	card.queue_free()

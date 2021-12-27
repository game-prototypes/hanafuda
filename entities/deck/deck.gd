class_name Deck
extends Node2D

export(PackedScene) var card_scene:PackedScene
export(Array,Resource) var cards=[]

var cards_left:Array

func _ready():
	cards_left=Array(cards)
	shuffle()

func size()->int:
	return cards_left.size()

func shuffle()->void:
	print("BEFORE SHUFFLE", cards_left)
	cards_left.shuffle()
	print("AFTER SHUFFLE", cards_left)
	

func get_card() -> Card:
	assert(size() > 0, "Deck empty")
	var card_info:CardResource=cards_left.pop_front()
	var card:Card=card_scene.instance()
	card.init_card(card_info)
	return card

class_name Deck
extends Node2D

export(PackedScene) var card_scene:PackedScene
export(Array,Resource) var cards=[]

var cards_left:Array

func _ready():
	#Assert deck is ok
	pass

func reset():
	cards_left=Array(cards)

func size()->int:
	return cards_left.size()

func shuffle()->void:
	cards_left.shuffle()

func get_card() -> Card:
	assert(size() > 0, "Deck empty")
	var card_info:CardResource=cards_left.pop_front()
	var card:Card=card_scene.instance()
	card.init_card(card_info)
	return card

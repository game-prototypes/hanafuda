class_name Deck
extends Node2D

var cards_left=48 # should be an array

export(PackedScene) var card_scene:PackedScene

func size()->int:
	return cards_left

func get_card() -> Card:
	assert(size() > 0, "Deck empty")
	var card:Card=card_scene.instance()
	card.init_card()
	cards_left-=1
	return card

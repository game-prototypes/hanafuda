class_name CardStackInterface
extends Node2D

enum CardFace {
	UP,
	DOWN
}

var cards:Array = [] # Include cards and null for cards removed, i is the card position

	
func add_card(card: Card) -> void:
	assert(true, "Not Implemented")

func remove_card(card: Card) -> void:
	assert(true, "Not Implemented")

func reset() -> Array:
	var result=get_cards()
	cards=[]
	return result

func get_cards() -> Array:
	var result=[]
	for card in cards:
		if card!=null:
			result.append(card)
	return result

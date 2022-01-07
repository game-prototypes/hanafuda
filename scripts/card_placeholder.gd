extends Node2D

var card

func add_card(new_card: Card) -> void:
	assert(card==null, "Placeholder already contains a card")

	new_card.faced_up=true

	# FIXME: card.faced_up needs to be set before add_child, these could be independent
	add_child(new_card)
	card=new_card
	card.move_to(Vector2.ZERO)
	#card.position=Vector2.ZERO

func remove_card() -> Card:
	assert(card!=null, "Can't remove null card")
	remove_child(card)
	
	var old_card=card
	card=null
	return old_card

extends Node2D

var card

func add_card(new_card: Card) -> void:
	assert(card==null, "Placeholder already contains a card")

	new_card.faced_up=true

	# FIXME: card.faced_up needs to be set before add_child, these could be independent
	add_child(new_card)
	card=new_card
	card.position=Vector2.ZERO
	#card.connect("on_click", self, "_on_card_click")

func remove_card() -> Card:
	assert(card!=null, "Can't remove null card")
	remove_child(card)
	#card.disconnect("on_click", self, "_on_card_click")
	
	var old_card=card
	card=null
	return old_card

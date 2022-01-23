class_name CardStack
extends CardStackInterface


export var separation:float = 10.0
export var max_cards:int=0 # 0 means no limit
export(CardFace) var card_orientation:int = CardFace.UP
export(bool) var selectable:bool=true
export(bool) var centered:bool=false

var selected_card

signal card_selected(card)

func add_card(card: Card) -> void:
	assert(_can_add_card(), "Cannot add card to stack, max size exceeded")
	# TODO: add card should add the card in the first null position
	if card_orientation==CardFace.UP:
		card.faced_up=true
	elif card_orientation==CardFace.DOWN:
		card.faced_up=false
	# FIXME: card.faced_up needs to be set before add_child, these could be independent
	var card_pos=_get_null_position(cards)
	
	Utils.reparent_node(card, self)
	
	_set_card_position(card, card_pos)
	card.resize(global_scale.x)
	

	#card.global_rotation=self.global_rotation
		
	card.connect("on_click", self, "_on_card_click")

func remove_card(card: Card) -> void:
	card.disconnect("on_click", self, "_on_card_click")
	var card_position=cards.find(card)
	assert(card_position>=0, "Card not found")
	cards[card_position]=null
	if card == selected_card:
		selected_card=null

func deselect_card() -> void:
	if selected_card != null:
		selected_card.show_outline(false)
		selected_card=null

func set_selectable(is_selectable:bool)->void:
	selectable=is_selectable

func _set_card_position(card:Card, index:int):
	if index==-1:
		cards.append(card)
		index=cards.size()-1
	else:
		cards[index]=card
	var card_coords=_get_card_coords(index)
	card.move_to(to_global(card_coords))

func _get_card_coords(index:int) -> Vector2:
	var row_cards=index
		
	var x_offset=(row_cards*(Constants.CARD_WIDTH+separation))
	if centered:
		x_offset=x_offset-(_get_max_width()/2)+(Constants.CARD_WIDTH/2)
	return Vector2(x_offset, 0)

func _get_max_width():
	assert(max_cards>0, "Cannot get max width if with no max cards")
	var separation_width=max(separation*(max_cards-1),0)
	var max_width=separation_width+max_cards*Constants.CARD_WIDTH
	return max_width

func _on_card_click(card:Card, button_index:int):
	if selectable:
		if selected_card==card:
			deselect_card()
		else:
			deselect_card()
			selected_card=card
			card.show_outline(true)
			emit_signal("card_selected", card)

func _get_null_position(arr: Array) -> int:
	return arr.find(null)

func _can_add_card()->bool:
	return max_cards==0 or cards.size()<max_cards

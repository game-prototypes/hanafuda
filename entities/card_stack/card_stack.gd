class_name CardStack
extends Node2D


enum CardFace {
	UP,
	DOWN
}

export var separation:Vector2=Vector2(10.0, 5.0)
export var row_size:int=0 # 0 means no rows
export(CardFace) var card_orientation:int = CardFace.UP
export(bool) var selectable:bool=true

var cards:Array = [] #Include cards and null for cards removed, i is the card position

var selected_card

signal card_selected(card)

func get_cards():
	var result=[]
	for card in cards:
		if card!=null:
			result.append(card)
	return result

func add_card(card: Card) -> void:
	# TODO: add card should add the card in the first null position
	if card_orientation==CardFace.UP:
		card.faced_up=true
	elif card_orientation==CardFace.DOWN:
		card.faced_up=false
	# FIXME: card.faced_up needs to be set before add_child, these could be independent
	$Cards.add_child(card)
	var card_pos=_get_null_position(cards)
	_set_card_position(card, card_pos)
		
	card.connect("on_click", self, "_on_card_click")

func remove_card(card: Card) -> void:
	card.disconnect("on_click", self, "_on_card_click")
	var card_position=cards.find(card)
	assert(card_position>=0, "Card not found")
	cards[card_position]=null
	$Cards.remove_child(card)

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
	card.move_to(card_coords)

func _get_card_coords(index:int) -> Vector2:
	var row=0
	var row_cards=index
	if row_size>0:
		row=floor(index/row_size)
		row_cards=index%row_size
		
	var y_offset=row*(Constants.CARD_HEIGHT+separation.y)
	var x_offset=(row_cards*(Constants.CARD_WIDTH+separation.x))
	return Vector2(x_offset, y_offset)

func _get_total_width():
	var max_width=max(separation.x*(row_size-1),0)+row_size*Constants.CARD_WIDTH
	
	var total_offset=max(separation.x*(cards.size()-1),0)
	var total_width=cards.size()*Constants.CARD_WIDTH+total_offset
	
	if row_size>0 and total_width>max_width:
		return max_width
	else:
		return total_width


func _on_card_click(card:Card, button_index:int):
	if can_select():
		if selected_card==card:
			deselect_card()
		else:
			deselect_card()
			selected_card=card
			card.show_outline(true)
			emit_signal("card_selected", card)

func _get_null_position(arr: Array) -> int:
	return arr.find(null)

func can_select()->bool:
	return selectable

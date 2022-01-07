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

func _ready():
	_draw_cards()

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
	if card_pos==-1:
		cards.append(card)
	else:
		cards[card_pos]=card
	_draw_cards()
	card.connect("on_click", self, "_on_card_click")

func remove_card(card: Card) -> void:
	card.disconnect("on_click", self, "_on_card_click")
	var card_position=cards.find(card)
	assert(card_position>=0, "Card not found")
	cards[card_position]=null
	#cards.remove(card_position)
	$Cards.remove_child(card)
	_draw_cards()

func deselect_card() -> void:
	if selected_card != null:
		selected_card.show_outline(false)
		selected_card=null

func set_selectable(is_selectable:bool)->void:
	selectable=is_selectable

func _draw_cards():
	var total_width=_get_total_width()
	var x_offset:float=-(total_width/2)
	var y_offset:float=0
	
	var i=0
	for card in cards:
		i+=1
		if i>row_size and row_size>0:
			i=1
			y_offset+=Constants.CARD_HEIGHT+separation.y
			x_offset=-(total_width/2)
			
		var card_position:Vector2=Vector2(x_offset, y_offset)
		if card!=null:
			card.move_to(card_position)
			#card.position=card_position
		x_offset+=Constants.CARD_WIDTH+separation.x

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

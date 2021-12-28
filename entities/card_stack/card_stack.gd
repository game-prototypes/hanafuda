class_name CardStack
extends Node2D


enum CardFace {
	UP,
	DOWN
}

export var separation:float=10.0
export(CardFace) var card_orientation:int = CardFace.UP

var cards:Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	_draw_cards()

func add_card(card: Card) -> void:
	if card_orientation==CardFace.UP:
		card.faced_up=true
	elif card_orientation==CardFace.DOWN:
		card.faced_up=false
	# FIXME: card.faced_up needs to be set before add_child, these could be independent
	$Cards.add_child(card)
	cards.append(card)
	_draw_cards()
	print(cards.size())
	

func _draw_cards():
	var total_offset=max(separation*(cards.size()-1),0)
	var total_width=cards.size()*Constants.CARD_WIDTH+total_offset
	var x_offset:float=-(total_width/2)
	for card in cards:
		var card_position:Vector2=Vector2(x_offset, 0)
		card.position=card_position
		x_offset+=Constants.CARD_WIDTH+separation

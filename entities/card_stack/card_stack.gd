class_name CardStack
extends Node2D

export(Array) var cards = []

export var separation:float=10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	_draw_cards()

func add_card(card: Card) -> void:
	add_child(card)
	cards.append(card)
	_draw_cards()

func _draw_cards():
	var x_offset:=0
	for card in cards:
		var card_position:Vector2=Vector2(x_offset, 0)
		card.position=card_position
		print(card.get_width())
		x_offset+=card.get_width()+separation
		print(x_offset)

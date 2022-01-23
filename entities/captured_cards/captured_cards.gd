extends Node2D

export var separation:float

onready var light_cards:CardStack=$LightCards
onready var animal_cards:CardStack=$AnimalCards
onready var ribbon_cards:CardStack=$RibbonCards
onready var plain_cards:CardStack=$PlainCards

func _ready():
	$LightCards.separation=separation
	$AnimalCards.separation=separation
	$RibbonCards.separation=separation
	$PlainCards.separation=separation

func add_card(card:Card):
	var card_info=card.info
	match card_info.type:
			Constants.CardType.PLAIN:
				plain_cards.add_card(card)
			Constants.CardType.POETRY_RIBBON,Constants.CardType.PLAIN_RIBBON,Constants.CardType.BLUE_RIBBON:
				ribbon_cards.add_card(card)
			Constants.CardType.LIGHT:
				light_cards.add_card(card)
			Constants.CardType.ANIMAL:
				animal_cards.add_card(card)

func get_cards()->Array:
	var result_array=[]
	result_array.append_array(light_cards.get_cards())
	result_array.append_array(animal_cards.get_cards())
	result_array.append_array(ribbon_cards.get_cards())
	result_array.append_array(plain_cards.get_cards())
	return result_array

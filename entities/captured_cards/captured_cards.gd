extends Node

export var separation:float

onready var light_cards:CardStackInterface=$LightCards
onready var animal_cards:CardStackInterface=$AnimalCards
onready var ribbon_cards:CardStackInterface=$RibbonCards
onready var plain_cards:CardStackInterface=$PlainCards

onready var light_label:Label=$LightCards/LightLabel
onready var animal_label:Label=$AnimalCards/AnimalLabel
onready var ribbon_label:Label=$RibbonCards/RibbonLabel
onready var plain_label:Label=$PlainCards/PlainLabel

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
	_update_labels()

func get_cards()->Array:
	var result_array=[]
	result_array.append_array(light_cards.get_cards())
	result_array.append_array(animal_cards.get_cards())
	result_array.append_array(ribbon_cards.get_cards())
	result_array.append_array(plain_cards.get_cards())
	return result_array

func _update_labels():
		var light_size=light_cards.get_cards().size()
		light_label.text="Light\n"+String(light_size)
		
		var animal_size=animal_cards.get_cards().size()
		animal_label.text="Animal\n"+String(animal_size)		
		
		var ribbon_size=ribbon_cards.get_cards().size()
		ribbon_label.text="Ribbon\n"+String(ribbon_size)
		
		var plain_size=plain_cards.get_cards().size()
		plain_label.text="Plain\n"+String(plain_size)

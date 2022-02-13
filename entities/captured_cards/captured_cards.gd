extends Node

export var separation:float

export(NodePath) var light_cards_path
export(NodePath) var animal_cards_path
export(NodePath) var ribbon_cards_path
export(NodePath) var plain_cards_path

onready var light_cards=get_node(light_cards_path)
onready var animal_cards=get_node(animal_cards_path)
onready var ribbon_cards=get_node(ribbon_cards_path)
onready var plain_cards=get_node(plain_cards_path)

export(NodePath) var light_cards_label
export(NodePath) var animal_cards_label
export(NodePath) var ribbon_cards_label
export(NodePath) var plain_cards_label


onready var light_label:Label=get_node(light_cards_label)
onready var animal_label:Label=get_node(animal_cards_label)
onready var ribbon_label:Label=get_node(ribbon_cards_label)
onready var plain_label:Label=get_node(plain_cards_label)

func _ready():
	light_cards.separation=separation
	animal_cards.separation=separation
	ribbon_cards.separation=separation
	plain_cards.separation=separation

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

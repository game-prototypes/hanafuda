extends Node2D

onready var light_cards:CardStack=$LightCards
onready var animal_cards:CardStack=$AnimalCards
onready var ribbon_cards:CardStack=$RibbonCards
onready var plain_cards:CardStack=$PlainCards

func add_card(card:Card):
	var card_info=card.info
	match card_info.type:
			Constants.CardType.PLAIN:
				plain_cards.add_card(card)
			[Constants.CardType.POETRY_RIBBON,Constants.CardType.PLAIN_RIBBON,Constants.CardType.BLUE_RIBBON]:
				ribbon_cards.add_card(card)
			Constants.CardType.LIGHT:
				light_cards.add_card(card)
			Constants.CardType.ANIMAL:
				animal_cards.add_card(card)

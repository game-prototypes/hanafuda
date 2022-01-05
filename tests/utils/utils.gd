extends Reference

var suite # A gut suite

func _init(_suite):
	suite=_suite

func create_card(card_info:Dictionary) -> Card:
	var resource=CardResource.new()
	resource.id=card_info.get("id", 3)
	resource.month=card_info.get("month", Constants.Month.JANUARY)
	resource.type=card_info.get("type", Constants.CardType.PLAIN)
	resource.sprite=Texture.new()
	var card=suite.autofree(Card.new())
	card.init_card(resource)
	return card

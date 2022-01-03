extends TestSuite

var PointsCalculator=preload("res://scripts/points_calculator.gd")

func test_assert_eq_number_not_equal2():
	var cards=[_create_card({
		"type": Constants.CardType.LIGHT
	}),
	_create_card({
		"type": Constants.CardType.LIGHT
	}),
	_create_card({
		"type": Constants.CardType.LIGHT
	}),
	_create_card({
		"type": Constants.CardType.LIGHT
	})]
	
	print(PointsCalculator.tally_points(cards, false))
	var points=PointsCalculator.tally_points(cards, false)
	assert_eq(points, 8, "Should fail.  1 != 2")

func _create_card(card_info:Dictionary) -> Card:
	var resource=CardResource.new()
	resource.id=card_info.get("id", 3)
	resource.month=card_info.get("month", Constants.Month.JANUARY)
	resource.type=card_info.get("type", Constants.CardType.PLAIN)
	resource.sprite=Texture.new()
	var card=Card.new()
	card.init_card(resource)
	return card

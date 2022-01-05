extends TestSuite

var PointsCalculator=preload("res://scripts/points_calculator.gd")


func test_points_calculator_light():
	var cards=[TestUtils.create_card({
		"type": Constants.CardType.LIGHT
	}),
	TestUtils.create_card({
		"type": Constants.CardType.LIGHT
	}),
	TestUtils.create_card({
		"type": Constants.CardType.LIGHT
	}),
	TestUtils.create_card({
		"type": Constants.CardType.LIGHT
	})]

	var points=PointsCalculator.tally_points(cards, false)
	assert_eq(points, 8, "Should fail.  1 != 2")

extends TestSuite

var PairChecker=preload("res://scripts/pair_checker.gd")


func test_get_possible_pairs():
	var cardPair1=TestUtils.create_card({
		"id": 3,
		"month": Constants.Month.JUNE
	})
	var cardPair2=TestUtils.create_card({
		"id": 5,
		"month": Constants.Month.JUNE
	})
	
	var cards1=[TestUtils.create_card({
		"id": 1,
		"month": Constants.Month.JANUARY
	}),
	TestUtils.create_card({
		"id": 2,
		"month": Constants.Month.JANUARY
	}),
	cardPair1,
	TestUtils.create_card({
		"id":4,
		"month": Constants.Month.MAY
	})]
	
	var cards2=[cardPair2,
	TestUtils.create_card({
		"id":6,
		"month": Constants.Month.APRIL
	})]

	var pairs=PairChecker.get_possible_pairs(cards1, cards2)
	assert_eq(pairs, [[cardPair1, cardPair2]])

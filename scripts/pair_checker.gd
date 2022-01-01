extends Reference

static func can_pair(cards1: Array, cards2: Array) -> bool:
	for card1 in cards1:
		for card2 in cards2:
			if same_month(card1, card2):
				return true
	return false

static func same_month(card1: Card, card2: Card) -> bool:
	return card1.info.month==card2.info.month

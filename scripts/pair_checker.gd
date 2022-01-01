extends Reference

static func can_pair(cards1: Array, cards2: Array) -> bool:
	for card1 in cards1:
		for card2 in cards2:
			if same_month(card1, card2):
				return true
	return false

static func same_month(card1: Card, card2: Card) -> bool:
	return card1.info.month==card2.info.month

# Returns array with 3 cards if hiki (3 of same month) or null
static func get_hiki(card: Card, cards: Array):
	var hiki=[]
	for candidate_card in cards:
		if same_month(candidate_card, card):
			hiki.append(candidate_card)
	
	if hiki.size()==3:
		return hiki
	else:
		return null

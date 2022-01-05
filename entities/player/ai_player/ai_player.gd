extends Player

func _on_hand_phase():
	match_hand_card()
	
func _on_deck_phase(card:Card):
	match_deck_card(card)
	
func match_hand_card():
	var table_cards=table.get_cards()
	var hand_cards=hand.get_cards()
	var pair_to_capture=_select_pair(hand_cards, table_cards)
	
	if pair_to_capture!=null:
		capture_hand_card(pair_to_capture[0], pair_to_capture[1])
	else:
		_discard_lowest_card()

func _discard_lowest_card():
	var hand_cards=hand.get_cards()
	var lowest=hand_cards[0]
	for card in hand_cards:
		if get_card_points(card)<get_card_points(lowest):
			lowest=card
	discard(lowest)

func match_deck_card(deck_card:Card):
	var pair_to_capture=_select_pair([deck_card], table.cards)
	assert(pair_to_capture!=null, "Deck card cannot be pair by AI (after checks)")
	capture_deck_card(pair_to_capture[1])

func calculate_pair_points(pair:Array) -> int:
	return get_card_points(pair[0])+get_card_points(pair[1])

func get_card_points(card:Card)->int:
	match card.info.type:
		Constants.CardType.LIGHT:
			return 10
		Constants.CardType.ANIMAL:
			return 5
		Constants.CardType.POETRY_RIBBON:
			return 5
		Constants.CardType.BLUE_RIBBON:
			return 5
		Constants.CardType.PLAIN_RIBBON:
			return 3
		Constants.CardType.PLAIN:
			return 1
	assert(true, "Invalid Card Type"+String(card.info.type))
	return 0

func _sort_pairs_points(pair_points1:Array, pair_points2:Array)->bool:
	if pair_points1[1] > pair_points2[1]:
		return true
	return false

func _select_pair(cards1: Array, cards2: Array):
	var pairs=PairChecker.get_possible_pairs(cards1, cards2)
	var pair_points=[]
	
	if pairs.size()==0:
		return null

	for pair in pairs:
		var points=calculate_pair_points(pair)
		pair_points.append([pair, points])
	pair_points.sort_custom(self, "_sort_pairs_points")
	
	return pair_points[0][0]

	

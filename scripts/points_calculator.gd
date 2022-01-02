extends Reference

const RAINMAN_ID = 41


static func tally_points(cards: Array,koi_koi: bool) -> int:
	return light_cards_points(cards)
	

static func filter_cards_by_type(cards:Array, type:int)->Array:
	var filtered_cards=[]
	for card in cards:
		if card.info.type==type:
			filtered_cards.append(card)
	return filtered_cards

static func light_cards_points(cards:Array) -> int:
	var light_cards:=filter_cards_by_type(cards, Constants.CardType.LIGHT)
	var count=light_cards.size()
	var has_rainman = has_card_with_id(cards, RAINMAN_ID)
	
	if has_rainman:
		match count:
			4:
				return 7
			5:
				return 10
	else:
		match count:
			3:
				return 5
			4:
				return 8
	return 0
	
static func has_card_with_id(cards:Array, id: int) -> bool:
	for card in cards:
		if card.info.id==id:
			return true
	return false

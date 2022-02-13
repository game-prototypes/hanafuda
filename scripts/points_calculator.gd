extends Reference

const RAINMAN_ID = 41
const INO_SHIKA_CHO_IDS = [25, 37, 21]

# TODO: fixme
static func tally_points(cards: Array) -> int:
	var points = light_cards_points(cards)+ plain_card_points(cards) +animal_card_points(cards)+ribbon_card_points(cards)
	return points
		

static func filter_cards_by_type(cards:Array, type:int)->Array:
	var filtered_cards=[]
	for cardInfo in cards:
		if cardInfo.type==type:
			filtered_cards.append(cardInfo)
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
	for cardInfo in cards:
		if cardInfo.id==id:
			return true
	return false

static func plain_card_points(cards: Array) -> int:
	var plain_cards:=filter_cards_by_type(cards, Constants.CardType.PLAIN)
	var count=plain_cards.size()
	return int(max(0, count-9))

static func animal_card_points(cards: Array) -> int:
	var animal_cards:=filter_cards_by_type(cards, Constants.CardType.ANIMAL)
	var count=animal_cards.size()
	if not has_ino_shika_cho(cards):
		return int(max(0, count-9))
	
	else:
		return 5+int(max(0, count-3))
	
static func has_ino_shika_cho(cards:Array) -> bool:
	for id in INO_SHIKA_CHO_IDS:
		if not has_card_with_id(cards, id):
			return false
	return true

static func ribbon_card_points(cards: Array) -> int:
	return 0

# TODO: extra combinations (sake)

extends Reference

var deck: Deck

var winner=null # Only used for winner at dealing (4 cards of same type)

func _init(_deck: Deck):
	deck=_deck

func deal(player1, player2, table:CardStack):
	deck.reset()
	deck.shuffle()
	deal_cards_to_stack(player1, 4)
	deal_cards_to_stack(player2, 4)
	deal_cards_to_stack(table, 4)
	deal_cards_to_stack(player1, 4)
	deal_cards_to_stack(player2, 4)
	deal_cards_to_stack(table, 4)
	
	if(invalid_deal(table)):
		_reset(player1,player2, table)
	
	if(invalid_deal(player1)):# TODO: player wins
		_reset(player1,player2, table)
		
	if(invalid_deal(player2)): # TODO: player wins
		_reset(player1,player2, table)
		
	
func deal_cards_to_stack(stack, number: int) -> void:
	for _i in range(number):
		var card = take_card()
		stack.add_card(card)

func take_card() -> Card:
	return deck.take_card()

func invalid_deal(stack):
	var cards=stack.get_cards()
	var month_count:={}
	for card in cards:
		print(card.info.month)
		var count=month_count.get(card.info.month, 0)
		month_count[card.info.month]=count+1

		if count+1 == 4:
			return true
	return false

func _reset(player1, player2, table):
	player1.reset()
	player2.reset()
	table.reset()
	deal(player1,player2, table)

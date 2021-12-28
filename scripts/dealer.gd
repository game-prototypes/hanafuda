extends Reference


static func deal(deck: Deck, player_stack: CardStack, oponent_stack:CardStack, table:CardStack):
	deck.reset()
	deck.shuffle()
	deal_cards_to_stack(deck, player_stack, 4)
	deal_cards_to_stack(deck, oponent_stack, 4)
	deal_cards_to_stack(deck, table, 4)
	
static func deal_cards_to_stack(deck: Deck, stack: CardStack, number: int) ->void:
	for i in range(number):
		var card = deck.get_card()
		stack.add_card(card)
	

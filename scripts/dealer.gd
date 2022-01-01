extends Reference

var deck: Deck

func _init(_deck: Deck):
	deck=_deck

func deal(player_stack: CardStack, oponent_stack:CardStack, table:CardStack):
	deck.reset()
	deck.shuffle()
	deal_cards_to_stack(player_stack, 4)
	deal_cards_to_stack(oponent_stack, 4)
	deal_cards_to_stack(table, 4)
	deal_cards_to_stack(player_stack, 4)
	deal_cards_to_stack(oponent_stack, 4)
	deal_cards_to_stack(table, 4)
	
func deal_cards_to_stack(stack: CardStack, number: int) -> void:
	for _i in range(number):
		var card = take_card()
		stack.add_card(card)

func take_card() -> Card:
	return deck.take_card()

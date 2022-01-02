extends Reference

var deck: Deck

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
	
func deal_cards_to_stack(stack, number: int) -> void:
	for _i in range(number):
		var card = take_card()
		stack.add_card(card)

func take_card() -> Card:
	return deck.take_card()

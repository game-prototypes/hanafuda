extends Player

func game_setup(_table:CardStack, _deck:Deck) -> void:
	.game_setup(_table, _deck)
	table.connect("card_selected", self, "_on_card_selected")
	hand.connect("card_selected", self, "_on_card_selected")

##### Behaviour: TODO: move to separate class
func _on_card_selected(card): # Called for any card (table or stack) selected
	assert(Global.turn==Global.Turn.Player, "Action on invalid turn")
	
	match phase:
		TurnPhase.HandMatching:
			var table_card=table.selected_card
			var player_card=hand.selected_card
			
			if player_card!=null and not _can_pair_hand():
				_deselect_cards()
				discard(player_card)
				
			elif table_card!=null and player_card!=null:
				_deselect_cards()
				if table_card.info.month==player_card.info.month:
					capture_hand_card(player_card, table_card)
		TurnPhase.DeckMatching:
			var table_card=table.selected_card
			_deselect_cards()
			if PairChecker.same_month(table_card, player_deck_card.card):
				capture_deck_card(table_card)
		
func _on_hand_phase()->void:
	hand.set_selectable(true)
	if _can_pair_hand():
		table.set_selectable(true)
	else:
		table.set_selectable(false)

func _on_deck_phase(_card:Card)->void:
	hand.set_selectable(false)
	table.set_selectable(true)
	
func _on_finish_turn():
	hand.set_selectable(false)
	table.set_selectable(false)

func _deselect_cards():
	table.deselect_card()
	hand.deselect_card()
	

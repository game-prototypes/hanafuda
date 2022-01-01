extends Node

var table:CardStack # Set by main TODO: improve
onready var player_stack:CardStack=$PlayerStack
onready var player_point_stack:CardStack=$PlayerPointStack
onready var player_deck_card=$DeckCardPlaceholder

signal cards_captured(player)

func _on_card_selected(card): # Called for any card (table or stack) selected
	assert(Global.turn==Global.Turn.Player, "Action on invalid turn")
	
	var table_card=table.selected_card
	var player_card=player_stack.selected_card
	prints(table_card, player_card)
	match Global.phase:
		Global.TurnPhase.HandMatching:
			if table_card!=null and player_card!=null:
				deselect_cards()
				if table_card.info.month==player_card.info.month:
					capture_card(table, table_card)
					capture_card(player_stack, player_card)
					disable_actions()
					emit_signal("cards_captured", self)
		Global.TurnPhase.DeckMatching:
			assert(player_deck_card.card != null, "Deck card not available")
			print("SELECT WITH DECK CARD")
					#emit_signal("phase_finished", Global.phase)
					# TODO: check for 3 cards with same month in table

func on_new_phase(phase:int)->void:
	match phase:
		Global.TurnPhase.DeckMatching:
			player_stack.set_selectable(true)
			table.set_selectable(true)
		Global.TurnPhase.HandMatching:
			player_stack.set_selectable(false)
			table.set_selectable(true)
		_:
			assert(true, "Invalid phase "+String(phase))

func on_turn_finished():
	disable_actions()

func deselect_cards():
	table.deselect_card()
	player_stack.deselect_card()

func capture_card(from_stack:CardStack, card: Card)->void:
	from_stack.remove_card(card)
	player_point_stack.add_card(card)
	
func disable_actions():
	player_stack.set_selectable(false)
	table.set_selectable(false)

func set_deck_card(card:Card):
	player_deck_card.add_card(card)

extends Node

var PairChecker = preload("res://scripts/pair_checker.gd")

var table:CardStack # Set by main TODO: improve
onready var player_stack:CardStack=$PlayerStack
onready var player_point_stack:CardStack=$PlayerPointStack
onready var player_deck_card=$DeckCardPlaceholder

signal player_action(player)

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
					emit_signal("player_action", self)
		Global.TurnPhase.DeckMatching:
			assert(player_deck_card.card != null, "Deck card not available")
			assert(table_card != null, "Table card not available")
			print("SELECT WITH DECK CARD")
			if PairChecker.same_month(table_card, player_deck_card.card):
				capture_card(table, table_card)
				var deck_card=player_deck_card.remove_card()
				player_point_stack.add_card(deck_card)
				emit_signal("player_action", self)
				disable_actions()
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
	if PairChecker.can_pair([card], table.cards):
		player_deck_card.add_card(card)
		
		# TODO: player action
		pass
	else:
		table.add_card(card)
		emit_signal("player_action", self)
	

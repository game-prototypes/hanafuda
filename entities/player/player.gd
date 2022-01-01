class_name Player
extends Node

var PairChecker = preload("res://scripts/pair_checker.gd")

enum TurnPhase {
	HandMatching,
	DeckMatching
}

var phase: int = TurnPhase.HandMatching

var table:CardStack # Set by main TODO: improve
var deck:Deck # Set by main 

onready var player_stack:CardStack=$PlayerStack
onready var player_point_stack:CardStack=$PlayerPointStack
onready var player_deck_card=$DeckCardPlaceholder

signal turn_finished(player)

func begin_turn():
	set_hand_phase()

func _on_card_selected(card): # Called for any card (table or stack) selected
	assert(Global.turn==Global.Turn.Player, "Action on invalid turn")
	
	match phase:
		TurnPhase.HandMatching:
			var table_card=table.selected_card
			var player_card=player_stack.selected_card
			if table_card!=null and player_card!=null:
				deselect_cards()
				if table_card.info.month==player_card.info.month:
					capture_card(table, table_card)
					capture_card(player_stack, player_card)
					set_deck_phase()
		TurnPhase.DeckMatching:
			var table_card=table.selected_card
			assert(player_deck_card.card != null, "Deck card not available")
			assert(table_card != null, "Table card not available")
			deselect_cards()
			if PairChecker.same_month(table_card, player_deck_card.card):
				capture_card(table, table_card)
				var deck_card=player_deck_card.remove_card()
				player_point_stack.add_card(deck_card)
				end_turn()
				# TODO: check for 3 cards with same month in table

func set_hand_phase()->void:
	phase=TurnPhase.HandMatching
	player_stack.set_selectable(true)
	table.set_selectable(true)
	# TODO: check if can pair

func set_deck_phase()->void:
	phase=TurnPhase.DeckMatching
	player_stack.set_selectable(false)
	table.set_selectable(true)
	
	_take_deck_card()

func deselect_cards():
	table.deselect_card()
	player_stack.deselect_card()

func capture_card(from_stack:CardStack, card: Card)->void:
	from_stack.remove_card(card)
	player_point_stack.add_card(card)
	
func end_turn():
	player_stack.set_selectable(false)
	table.set_selectable(false)
	emit_signal("turn_finished", self)
	

func _take_deck_card():
	var card=deck.take_card()
	
	if PairChecker.can_pair([card], table.cards):
		player_deck_card.add_card(card)  
	else:
		table.add_card(card)
		end_turn()


func next_phase() -> int:
	if phase==TurnPhase.HandMatching:
		phase=TurnPhase.DeckMatching
	elif phase==TurnPhase.DeckMatching:
		phase=TurnPhase.HandMatching
	return phase	
	
func is_last_phase()->bool:
	return phase==TurnPhase.DeckMatching

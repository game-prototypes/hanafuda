class_name Player
extends Node
# Player contains a player state and valid actions

var PairChecker = preload("res://scripts/pair_checker.gd")

enum TurnPhase {
	HandMatching,
	DeckMatching
}

var phase: int = TurnPhase.HandMatching
var current_turn: bool = false

var table:CardStack # Set by main TODO: improve
var deck:Deck # Set by main 

onready var player_stack:CardStack=$PlayerStack
onready var captured_cards=$CapturedCards
onready var player_deck_card=$DeckCardPlaceholder

signal turn_finished(player)

func game_setup(_table:CardStack, _deck:Deck) -> void:
	assert(table==null and deck==null, "Player is already set")
	table=_table
	deck=_deck

func begin_turn():
	assert(current_turn==false, "Current turn already true")
	current_turn=true
	_set_hand_phase()

func add_card(card:Card):
	player_stack.add_card(card)

func get_captured_cards() -> Array:
	return captured_cards.get_cards()
# Actions
# Actions are public methods that performs an action or asserts if it is not valid

func discard(card: Card) -> void:
	_assert_action(TurnPhase.HandMatching)
	player_stack.remove_card(card)
	table.add_card(card)
	_set_deck_phase()

func capture_hand_card(hand_card: Card, table_card: Card) -> void:
	_assert_action(TurnPhase.HandMatching)
	var card_from_table=_get_table_cards_to_capture(hand_card, table_card)
	for card_to_capture in card_from_table:
		_capture_card_from_stack(table, card_to_capture)
	_capture_card_from_stack(player_stack, hand_card)
	_set_deck_phase()	

func capture_deck_card(table_card: Card) -> void:
	_assert_action(TurnPhase.DeckMatching)
	var deck_card=player_deck_card.card
	assert(deck_card != null, "Deck card not available")
	
	var card_from_table=_get_table_cards_to_capture(deck_card, table_card)
	for card_to_capture in card_from_table:
		_capture_card_from_stack(table, card_to_capture)
	player_deck_card.remove_card()
	captured_cards.add_card(deck_card)
	_finish_turn()

func discard_deck_card():
	_assert_action(TurnPhase.DeckMatching)
	var deck_card=player_deck_card.card
	player_deck_card.remove_card() # FIXME: ORDER IS IMPORTANT (remove->add)
	table.add_card(deck_card)
	
## Lifecycle events 
func _set_hand_phase()->void:
	print("Hand Phase")	
	phase=TurnPhase.HandMatching
	_on_hand_phase()
		
func _set_deck_phase()->void:
	print("Deck Phase")
	phase=TurnPhase.DeckMatching
	var card=_take_deck_card()
		
	if PairChecker.can_pair([card], table.cards):
		_on_deck_phase()
	else:
		discard_deck_card()
		_finish_turn()
	
func _finish_turn():
	print("Finish Turn")
	current_turn=false
	_on_finish_turn()
	emit_signal("turn_finished", self)

## Behaviour Hooks
func _on_finish_turn():
	assert(true, "Behaviour Not Implements")

func _on_hand_phase()->void:
	assert(true, "Behaviour Not Implements")

func _on_deck_phase()->void:
	assert(true, "Behaviour Not Implements")

#####


func _can_pair_hand() -> bool:
	return PairChecker.can_pair(player_stack.cards, table.cards)

func _take_deck_card() -> Card:
	_assert_action(TurnPhase.DeckMatching)
	var card=deck.take_card()
	
	player_deck_card.add_card(card) 
	return card

func _capture_card_from_stack(from_stack:CardStack, card: Card)->void:
	from_stack.remove_card(card)
	captured_cards.add_card(card)

func _assert_action(expected_phase: int):
	assert(current_turn and phase==expected_phase, "Invalid action")

func _get_table_cards_to_capture(player_card: Card, table_card:Card)->Array:
	assert(PairChecker.same_month(player_card, table_card), "Invalid pair")
	var hiki=PairChecker.get_hiki(player_card, table.cards)
	if hiki!=null:
		assert(hiki.size()==3, "Invalid Hiki")
		return hiki
	else:
		return [table_card]


	

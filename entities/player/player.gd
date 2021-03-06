class_name Player
extends Node
# Player contains a player state and valid actions

var id
var PairChecker = preload("res://scripts/pair_checker.gd")
var PointsCalculator = preload("res://scripts/points_calculator.gd")

enum TurnPhase {
	HandMatching,
	DeckMatching,
	KoiKoi
}

var phase: int = TurnPhase.HandMatching
var current_turn: bool = false

var table:CardStack # Set by main TODO: improve
var deck:Deck # Set by main 

onready var hand:CardStack=$Hand
onready var player_deck_card=$DeckCardPlaceholder

export(NodePath) var captured_cards_path
onready var captured_cards=get_node(captured_cards_path)

var points=0

signal turn_finished(player, win_round)
signal koi_koi
signal _capture_finished

func _ready():
	captured_cards=get_node(captured_cards_path)
	assert(hand!=null and captured_cards!=null, "Hand and captured cards not avilable for player")

func game_setup(_id: int, _table:CardStack, _deck:Deck) -> void:
	assert(table==null and deck==null and id==null, "Player is already set")
	table=_table
	deck=_deck
	id=_id

func begin_turn():
	assert(table!=null and id!=null and deck!=null, "Player not set")
	assert(current_turn==false, "Current turn already true")
	current_turn=true
	_set_hand_phase()

func add_card(card:Card):
	hand.add_card(card)

func reset():
	return hand.reset()

func get_captured_cards() -> Array:
	return captured_cards.get_cards()

func hand_cards_count()->int:
	return hand.get_cards().size()

func get_cards(): # Returns cards in hand
	return hand.get_cards()

# Actions
## Actions are public methods that perform an action or asserts if it is not valid

func discard(card: Card) -> void:
	_assert_action(TurnPhase.HandMatching)
	hand.remove_card(card)
	table.add_card(card)
	_set_deck_phase()

func capture_hand_card(hand_card: Card, table_card: Card) -> void:
	_assert_action(TurnPhase.HandMatching)
	var cards_to_capture=_get_table_cards_to_capture(hand_card, table_card)
	for card_to_capture in cards_to_capture:
		table.remove_card(card_to_capture)
	hand.remove_card(hand_card)
	_capture_cards(hand_card, cards_to_capture, cards_to_capture[0].global_position)
	yield(self, "_capture_finished")
	_set_deck_phase()	

func capture_deck_card(table_card: Card) -> void:
	_assert_action(TurnPhase.DeckMatching)
	var deck_card=player_deck_card.card
	assert(deck_card != null, "Deck card not available")
	
	var cards_to_capture=_get_table_cards_to_capture(deck_card, table_card)
	for card_to_capture in cards_to_capture:
		table.remove_card(card_to_capture)
	player_deck_card.remove_card()
	_capture_cards(deck_card, cards_to_capture, cards_to_capture[0].global_position)
	
	yield(self, "_capture_finished")
	_update_points_and_finish_turn()



func koi_koi():
	_assert_action(TurnPhase.KoiKoi)
	emit_signal("koi_koi")
	_finish_turn()

func end_round():
	print("End Round")
	_assert_action(TurnPhase.KoiKoi)
	_finish_turn(true)	

func discard_deck_card():
	_assert_action(TurnPhase.DeckMatching)
	var deck_card=player_deck_card.card
	player_deck_card.remove_card() # FIXME: ORDER IS IMPORTANT (remove->add)
	table.add_card(deck_card)
	
# Lifecycle events 
func _set_hand_phase()->void:
	print("Hand Phase")	
	phase=TurnPhase.HandMatching
	_on_hand_phase()
		
func _set_deck_phase()->void:
	print("Deck Phase")
	phase=TurnPhase.DeckMatching
	var card=_take_deck_card()
		
	if PairChecker.can_pair([card], table.get_cards()):
		_on_deck_phase(card)
	else:
		discard_deck_card()
		_update_points_and_finish_turn()

func _set_koi_koi_phase()->void:
	print("koi koi phase")
	phase=TurnPhase.KoiKoi
	if hand_cards_count()>0:
		_on_koikoi_phase()
	else:
		end_round()

func _update_points_and_finish_turn():
	var new_points=PointsCalculator.tally_points(get_captured_cards())
	prints("Points", new_points)
	if new_points > points:
		points=new_points
		_set_koi_koi_phase()
	else:
		_finish_turn()

func _finish_turn(end_round: bool = false):
	print("Finish Turn")
	current_turn=false
	
	_on_finish_turn()
	emit_signal("turn_finished", self, end_round)

# Behaviour Hooks
func _on_finish_turn():
	pass

func _on_hand_phase()->void:
	assert(false, "Behaviour Not Implemented")

func _on_deck_phase(_card:Card)->void:
	assert(false, "Behaviour Not Implemented")

func _on_koikoi_phase()->void:
	assert(false, "Behaviour Not Implemented")

# Private actions and helpers
func _can_pair_hand() -> bool:
	return PairChecker.can_pair(hand.get_cards(), table.get_cards())

func _take_deck_card() -> Card:
	_assert_action(TurnPhase.DeckMatching)
	var card=deck.take_card()
	
	player_deck_card.add_card(card) 
	return card

func _assert_action(expected_phase: int):
	assert(current_turn and phase==expected_phase, "Invalid action")

func _get_table_cards_to_capture(player_card: Card, table_card:Card)->Array:
	assert(PairChecker.same_month(player_card, table_card), "Invalid pair")
	var hiki=PairChecker.get_hiki(player_card, table.get_cards())
	if hiki!=null:
		assert(hiki.size()==3, "Invalid Hiki")
		return hiki
	else:
		return [table_card]
	
func _capture_cards(card1: Card, cards: Array, capture_position: Vector2):
	for card in cards:
		card.move_to(capture_position)
	
	card1.call_deferred("move_to", capture_position)# just to avoid yield race conditions
	yield(card1,"on_move_finished")
	yield(get_tree().create_timer(0.1), "timeout")
	
	captured_cards.call_deferred("add_card", card1) # just to avoid yield race conditions
	for card in cards:
		captured_cards.add_card(card)
	yield(card1,"on_move_finished")
	emit_signal("_capture_finished")

extends Node

var table:CardStack # Set by main TODO: improve
onready var player_stack:CardStack=$PlayerStack
onready var player_point_stack:CardStack=$PlayerPointStack

func _on_card_selected(card): # Called for any card (table or stack) selected
	# TODO: check for turn?
	var table_card=table.selected_card
	var player_card=player_stack.selected_card

	if table_card!=null and player_card!=null:
		deselect_cards()
		if table_card.info.month==player_card.info.month:
			capture_card(table, table_card)
			capture_card(player_stack, player_card)
			# TODO: check for 3 cards with same month in table


func deselect_cards():
	table.deselect_card()
	player_stack.deselect_card()

func capture_card(from_stack:CardStack, card: Card)->void:
	from_stack.remove_card(card)
	player_point_stack.add_card(card)
	

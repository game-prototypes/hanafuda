extends Node2D

var Dealer = preload("res://scripts/dealer.gd")

onready var deck:Deck=$Deck
onready var table:CardStack=$Table
onready var player_spawner=$Players
onready var round_summary:PopupDialog=$CanvasLayer/RoundSummary

var dealer
var koi_koi: bool = false

var turn_initiative:=[] # Represents the order of turns (players ids), beggining by index 0

func _enter_tree():
	randomize()

func _ready():
	player_spawner.table=table
	player_spawner.deck=deck
	
	for player_info in GameState.players.values():
		var is_main=player_info.id==GameState.main_player
		var player=player_spawner.spawn_player(player_info, is_main)
		player.connect("turn_finished", self, "_on_player_turn_finished")
		player.connect("koi_koi", self, "_on_koikoi")
		turn_initiative.append(player_info.id) 

	dealer=Dealer.new(deck)
	var players=player_spawner.players
	dealer.deal(players[0], players[1], table)
	_begin_player_turn(turn_initiative[0])

func _begin_player_turn(id:int):
	prints("Player", id, "Turn")
	var player=player_spawner.find_player(id)
	player.begin_turn()
	
func _on_koikoi():
	koi_koi=true
	
func _on_player_turn_finished(player:Player, round_end: bool):
	var index=turn_initiative.find(player.id)
	assert(index!=-1, "Player initiative not found")
	if round_end:
		end_round(player)
	elif no_cards_left_in_players():
		end_round()
	else:
		index+=1
		if index==turn_initiative.size(): # TODO this can be a one liner
			index=0
		_begin_player_turn(turn_initiative[index])

func end_round(winner=null):
	print("ROUND END")
	
	for player_info in GameState.players.values():
		if winner!=null and winner.id==player_info.id:
			player_info.add_round_points(winner.points)
		else:
			player_info.add_round_points(0)
	
	#current_round+=1
	if GameState.current_round==11:
		# LAST ROUND
		var game_winner=GameState.get_winning_player()
		round_summary.show_winner(game_winner)
	#else:
	round_summary.fill_table(GameState.players.values()) # FIXME: order
	round_summary.set_round(GameState.current_round)
	round_summary.show_modal(true)

func end_match():
	print("End Match")

func no_cards_left_in_players()->bool:
	for player in get_players():
		if player.hand_cards_count()==0:
			return true
	return false

func get_players()->Array:
	return player_spawner.players

func _on_next_round():
	GameState.current_round+=1
	SceneSwitcher.switch_to_game_round_scene()

func _on_end_game():
	SceneSwitcher.switch_to_main_menu_scene()

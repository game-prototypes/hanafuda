extends Control

export(PackedScene) var points_cell:PackedScene
export(Array, NodePath) var total_labels_path:Array
var total_labels:=[]

onready var round_label=$RoundLabel
onready var points_table=$PointsTable

onready var end_game_button=$EndGameButton
onready var next_round_button=$NextRoundButton

onready var winner_label=$WinnerLabel

const MAX_ROUNDS=12
var current_round

signal next_round
signal end_game

func _ready():
	assert(total_labels_path.size()==2, "Total labels not set")
	for label_path in total_labels_path:
		total_labels.append(get_node(label_path))

func set_round(_current_round: int):
	current_round=_current_round
	round_label.text="Round "+String(current_round)
	if is_final_round(): # TODO: should be set outside
		end_game_button.show()
		next_round_button.hide()
	else:
		end_game_button.hide()
		next_round_button.show()	

func fill_table(players:Array):
	_fill_table_header(MAX_ROUNDS)
	for i in range(players.size()):
		var player=players[i]
		_fill_table_row(player, MAX_ROUNDS)
		total_labels[i].text=String(player.total_points)

func show_winner(winner: PlayerInfo):
	winner_label.text="WINNER: "+winner.name+"\n"+"Points: "+String(winner.total_points)
	winner_label.show()

func is_final_round():
	return MAX_ROUNDS==current_round

func _fill_table_header(max_rounds:int):
	for round_index in range(max_rounds):
		var header_label=_instance_cell()
		header_label.get_node("Label").text=String(round_index) # TODO: fix
		
func _fill_table_row(player:PlayerInfo, max_rounds:int):
	assert(player.points_per_round.size()<=max_rounds, "More points than maximum rounds")
	for round_index in range(max_rounds):
		var points_label=_instance_cell()
		if player.points_per_round.size() > round_index:
			var points=player.points_per_round[round_index]
			points_label.get_node("Label").text=String(points) # TODO: fix

func _instance_cell() -> Control:
	var instance=points_cell.instance()
	instance.size_flags_horizontal=SIZE_EXPAND
	points_table.add_child(instance)
	return instance

func _on_next_round_pressed():
	emit_signal("next_round")

func _on_end_game_pressed():
	emit_signal("end_game")

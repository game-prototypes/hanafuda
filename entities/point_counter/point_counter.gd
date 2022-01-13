extends Control

export(PackedScene) var points_cell:PackedScene
export(Array, NodePath) var total_labels_path:Array
var total_labels:=[]

onready var round_label=$RoundLabel
onready var points_table=$PointsTable

signal next_round

func _ready():
	assert(total_labels_path.size()==2, "Total labels not set")
	for label_path in total_labels_path:
		total_labels.append(get_node(label_path))
	round_label.text="Round "+String(GameState.current_round)


func fill_table(players:Array):
	_fill_table_header(12)
	for i in range(players.size()):
		var player=players[i]
		_fill_table_row(player, 12)
		total_labels[i].text=String(player.total_points)

func _fill_table_header(max_rounds:int):
	for round_index in range(max_rounds):
		var header_label=_instance_cell()
		header_label.get_node("Label").text=String(round_index) # TODO: fix
		
func _fill_table_row(player:PlayerInfo, max_rounds:int):
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

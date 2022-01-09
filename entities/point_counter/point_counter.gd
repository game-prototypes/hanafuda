extends Control


onready var round_label=$Panel/RoundLabel
onready var points_table=$Panel/PointsTable


# Called when the node enters the scene tree for the first time.
func _ready():
	round_label.text=String(GameState.current_round)


func fill_table(players:Array):
	for player in players:
		fill_table_row(player, 12)


func fill_table_row(player:PlayerInfo, max_rounds:int):
	var name_label=Label.new()
	name_label.text=String(player.id)
	points_table.add_child(name_label)
	
	for round_index in range(max_rounds):
		var points_label=Label.new()
		if player.points_per_round.size() > round_index:
			var points=player.points_per_round[round_index]
			points_label.text=String(points)
		points_table.add_child(points_label)

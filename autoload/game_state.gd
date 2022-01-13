extends Node
# Game state existing across multiple rounds

var current_round:=1
var players:=Dictionary()

var main_player:int

func reset():
	current_round=1
	players=Dictionary()

func add_player(id:int, type:int, main:bool=false):
	players[id]=PlayerInfo.new(id, {
		"type": type,
	})
	if main:
		main_player=id

func get_player_info(id:int):
	assert(players.has(id), "player not found")
	return players.get(id)

# The array contains pairs [id, points]
func on_finish_round(points_per_player: Array):
	assert(points_per_player.size()==players.size(), "Not all points are tallyed on finish round")
	current_round+=1	
	for player_points in points_per_player:
		var round_points=player_points[1]
		assert(round_points>0, "Points cannot be negative")
		var player_info=get_player_info(player_points[0])
		player_info.add_round_points(round_points)
		

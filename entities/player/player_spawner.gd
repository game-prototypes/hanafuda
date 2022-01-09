extends Node2D

export(float) var players_offset=400
export(PackedScene) var human_player:PackedScene
export(PackedScene) var ai_player:PackedScene

var players=[]

onready var table # set by main
onready var deck

func find_player(id:int)->Player:
	for player in players:
		if player.id==id:
			return player
	assert(false, "No player found")
	return null

func spawn_player(player_info:PlayerInfo, main:bool=false) -> Player:
	assert(table!=null and deck!=null, "Spawner table and deck not set")
	assert(players.size()<2, "currently only 2 players supported")
	var player_instance:=_get_player_instance(player_info.type)
	add_child(player_instance)	
	player_instance.game_setup(player_info.id, table, deck)
	players.append(player_instance)	
	if main:
		player_instance.position=Vector2(0, +players_offset)
	else:
		player_instance.position=Vector2(0, -players_offset)
		player_instance.rotation_degrees=180
	return player_instance

func _get_player_instance(type:int) -> Player:
	var instance
	match type:
		Constants.PlayerType.HUMAN:
			instance=human_player.instance()
		Constants.PlayerType.AI:
			instance=ai_player.instance()
		_:
			assert(false, "Invalid player type "+String(type))
	return instance

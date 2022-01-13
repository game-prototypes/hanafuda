class_name PlayerInfo
extends Reference

var points_per_round=[]
var total_points=0
var type: int=Constants.PlayerType.HUMAN
var id
var name

func _init(_id:int, options: Dictionary):
	type=options["type"]
	id=_id
	name="Player "+String(id)

func add_round_points(points:int):
	total_points+=points
	points_per_round.append(points)

extends Node

enum Turn {
	Player,
	Oponent
}



var turn = Turn.Player # First turn

func next_turn() -> int:
	if turn==Turn.Player:
		turn=Turn.Oponent
	elif turn==Turn.Oponent:
		turn=Turn.Player
	return turn




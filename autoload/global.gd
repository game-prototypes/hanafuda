extends Node

enum Turn {
	Player,
	Oponent
}

enum TurnPhase {
	HandCapture,
	DeckCapture
}

var turn = Turn.Player # First turn
var phase

func next_turn():
	if turn==Turn.Player:
		turn=Turn.Oponent
	elif turn==Turn.Oponent:
		turn=Turn.Player

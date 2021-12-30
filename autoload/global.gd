extends Node

enum Turn {
	Player,
	Oponent
}

enum TurnPhase {
	HandMatching,
	DeckMatching
}

var turn = Turn.Player # First turn
var phase = TurnPhase.HandMatching

func next_turn() -> int:
	if turn==Turn.Player:
		turn=Turn.Oponent
	elif turn==Turn.Oponent:
		turn=Turn.Player
	
	phase=TurnPhase.HandMatching
	return turn

func next_phase() -> int:
	if phase==TurnPhase.HandMatching:
		phase=TurnPhase.DeckMatching
	elif phase==TurnPhase.DeckMatching:
		phase=TurnPhase.HandMatching
	return phase

func is_last_phase()->bool:
	return phase==TurnPhase.DeckMatching

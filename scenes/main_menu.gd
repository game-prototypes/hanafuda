extends Control

func play_game():
	GameState.reset()
	GameState.add_player(1, Constants.PlayerType.HUMAN, true)
	GameState.add_player(2, Constants.PlayerType.AI)
	
	SceneSwitcher.switch_to_game_round_scene()

func exit():
	get_tree().quit() 

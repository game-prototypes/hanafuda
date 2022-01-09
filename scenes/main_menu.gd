extends Control

export(PackedScene) var main_game_scene:PackedScene

func _ready():
	assert(main_game_scene!=null, "Main Game Scene not set")

func play_game():
	GameState.reset()
	GameState.add_player(1, Constants.PlayerType.HUMAN, true)
	GameState.add_player(2, Constants.PlayerType.AI)
	
	var res=get_tree().change_scene_to(main_game_scene)
	assert(res==OK, "Cannot load main game scene")

func exit():
	get_tree().quit() 

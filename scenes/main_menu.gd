extends Control

export(PackedScene) var main_game_scene:PackedScene

func _ready():
	assert(main_game_scene!=null, "Main Game Scene not set")

func play_game():
	var res=get_tree().change_scene_to(main_game_scene)
	print(res)
	assert(res==OK, "Cannot load main game scene")

func exit():
	get_tree().quit() 

extends Node

export(PackedScene) var game_round_scene:PackedScene
export(PackedScene) var main_menu_scene:PackedScene
export(PackedScene) var mobile_game_scene:PackedScene

func _ready():
	assert(game_round_scene!=null, "Game Scene not set")
	assert(main_menu_scene!=null, "Main Menu Scene not set")


func switch_to_game_round_scene():
	var mobile=ProjectSettings.get_setting("application/config/mobile")
	if mobile:
		_switch_to_scene(mobile_game_scene)
	else:
		_switch_to_scene(game_round_scene)
	
func switch_to_main_menu_scene():
	_switch_to_scene(main_menu_scene)

func _switch_to_scene(scene:PackedScene):
	var res=get_tree().change_scene_to(scene)
	assert(res==OK, "Cannot load scene")

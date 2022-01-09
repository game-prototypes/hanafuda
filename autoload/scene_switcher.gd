extends Node

export(PackedScene) var game_round_scene:PackedScene
export(PackedScene) var main_menu_scene:PackedScene

func _ready():
	assert(game_round_scene!=null, "Game Scene not set")
	assert(main_menu_scene!=null, "Main Menu Scene not set")


func switch_to_game_round_scene():
	_switch_to_scene(game_round_scene)

func reset_scene():
	get_tree().reload_current_scene()

func _switch_to_scene(scene:PackedScene):
	var res=get_tree().change_scene_to(scene)
	assert(res==OK, "Cannot load scene")

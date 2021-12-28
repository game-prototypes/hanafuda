class_name Card
extends Node2D

export(Texture) var back_texture: Texture

signal on_click(button_index)

onready var sprite:Sprite=$Sprite

var info:CardResource
var faced_up:=true

func _ready():
	assert(info!=null, "Can instance card without info")
	_set_texture()

func init_card(card_info:CardResource)->void:
	assert(info == null, "Can't init card twice")
	info=card_info


func _set_texture()->void:
	if faced_up:
		sprite.set_texture(info.sprite)
	else:
		sprite.set_texture(back_texture)

#func get_width()->float:
#	var rect:Rect2=sprite.get_rect()
#	var scaled_size=rect.size*sprite.global_scale
#	return scaled_size.x


func _on_click(button_index):
	emit_signal("on_click", button_index)

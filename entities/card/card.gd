class_name Card
extends Node2D

onready var sprite:Sprite=$Sprite

var info:CardResource

func _ready():
	assert(info!=null, "Can instance card without info")
	sprite.set_texture(info.sprite)

func init_card(card_info:CardResource)->void:
	assert(info == null, "Can't init card twice")
	info=card_info

#func get_width()->float:
#	var rect:Rect2=sprite.get_rect()
#	var scaled_size=rect.size*sprite.global_scale
#	return scaled_size.x

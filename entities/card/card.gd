class_name Card
extends Node2D

onready var sprite:Sprite=$Sprite

func init_card()->void:
	pass

func get_width()->float:
	var rect:Rect2=sprite.get_rect()
	var scaled_size=rect.size*sprite.global_scale
	return scaled_size.x

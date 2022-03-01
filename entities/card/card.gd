class_name Card
extends Node2D

export(Texture) var back_texture: Texture
export(float) var movement_speed: float = 3000.0

signal on_click(card, button_index)
signal on_move_finished(card)

onready var sprite:Sprite=$Sprite
onready var tween:Tween=$Tween

var info:CardResource

var faced_up:=true setget _set_face

func _ready():
	assert(info!=null, "Can instance card without info")
	_update_texture()

func init_card(card_info:CardResource)->void:
	assert(info == null, "Can't init card twice")
	info=card_info

func show_outline(value: bool)->void:
	$Outline.visible=value

func move_to(global_pos: Vector2):
	var time=global_position.distance_to(global_pos)/movement_speed
	#tween.remove_all()
	tween.remove(self, "global_position")
	tween.interpolate_property(self, "global_position",
		global_position, global_pos, time,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func resize(new_scale: float):
	# TODO: interpolate
	global_scale=Vector2(new_scale, new_scale)


func _update_texture()->void:
	if faced_up:
		sprite.set_texture(info.sprite)
	else:
		sprite.set_texture(back_texture)

func _on_click(button_index):
	emit_signal("on_click", self, button_index)

func _set_face(face:bool):
	faced_up=face
	if sprite != null:
		_update_texture()


func _on_move_completed(object, key):
	emit_signal("on_move_finished", self)

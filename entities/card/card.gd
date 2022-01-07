class_name Card
extends Node2D

export(Texture) var back_texture: Texture
export(float) var movement_speed: float = 200.0

signal on_click(card, button_index)

onready var sprite:Sprite=$Sprite
onready var tween:Tween=$Tween

var info:CardResource
var faced_up:=true

func _ready():
	assert(info!=null, "Can instance card without info")
	_set_texture()

func init_card(card_info:CardResource)->void:
	assert(info == null, "Can't init card twice")
	info=card_info

func show_outline(value: bool)->void:
	$Outline.visible=value

func move_to(pos: Vector2):
	var time=position.distance_to(pos)/movement_speed
	tween.stop_all()
	tween.interpolate_property(self, "position",
		position, pos, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	#position=pos

func _set_texture()->void:
	if faced_up:
		sprite.set_texture(info.sprite)
	else:
		sprite.set_texture(back_texture)

func _on_click(button_index):
	emit_signal("on_click", self, button_index)

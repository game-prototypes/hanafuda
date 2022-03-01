extends Control

export(float) var separation=10
var cards:Array = []
var card_height

onready var cards_container=$Cards

func _ready():
	card_height=$Cards.rect_size.y

func add_card(card: Card, target:Vector2) -> void:
	card.move_to(target)
	card.connect("on_move_finished", self, "_on_card_moved")


func _on_card_moved(card) -> void:
	cards.append(card.info)
	card.queue_free()
	var card_image=TextureRect.new()

	card_image.texture=card.info.sprite
	card_image.expand=true
	card_image.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	var original_size=card.info.sprite.get_size()
	var aspect=original_size.aspect()
	
	var card_width=aspect*card_height
	card_image.rect_size=Vector2(aspect*card_height, card_height)
	
	var card_index=cards.size()
	card_image.rect_position=_get_card_coords(card_index, card_width)

	$Cards.add_child(card_image)
	

func _get_card_coords(index:int, card_width: float) -> Vector2:
	var row_cards=index-1
		
	var x_offset=(row_cards*(card_width+separation))
	return Vector2(x_offset, 0)	
	
	
func remove_card(card: Card) -> void:
	assert(true, "Cant remove card from UI")

func get_cards()->Array:
	return cards

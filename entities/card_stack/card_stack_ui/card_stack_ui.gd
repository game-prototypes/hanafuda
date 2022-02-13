extends Control

var cards:Array = []

func add_card(card: Card) -> void:
	cards.append(card.info)
	card.queue_free()
	var card_image=TextureRect.new()
	card_image.texture=card.info.sprite
	card_image.expand=true
	card_image.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	card_image.rect_min_size=Vector2(100,0)
	$Cards.add_child(card_image)
	
	

func remove_card(card: Card) -> void:
	assert(true, "Cant remove card from UI")

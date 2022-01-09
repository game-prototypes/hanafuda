class_name Deck
extends Node2D

export(PackedScene) var card_scene:PackedScene
export(Array,Resource) var cards=[]

var cards_left:Array

onready var dealed_cards=$DealedCards

func _ready():
	#Assert deck is ok (ids and months)
	pass

func reset():
	cards_left=[]+cards # clone
	#Delete all cards in $DealedCards
	assert(size()==48, "Not enough cards in ready: "+String(size()))

func size()->int:
	return cards_left.size()

func shuffle()->void:
	cards_left.shuffle()

func take_card() -> Card:
	assert(size() > 0, "Deck empty")
	var card_info:CardResource=cards_left.pop_front()
	var card:Card=card_scene.instance()
	card.init_card(card_info)
	card.faced_up=false
	card.position=Vector2.ZERO	
	dealed_cards.add_child(card)
	return card

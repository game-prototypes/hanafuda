extends Node2D

var Dealer = preload("res://scripts/dealer.gd")

onready var deck:Deck=$Deck
onready var player_stack:CardStack=$PlayerStack
onready var oponent_stack:CardStack=$OponentStack
onready var table:CardStack=$Table


func _enter_tree():
	randomize()

func _ready():
	Dealer.deal(deck, player_stack, oponent_stack, table)

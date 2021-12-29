extends Node2D

var Dealer = preload("res://scripts/dealer.gd")

onready var deck:Deck=$Deck
onready var player_stack:CardStack=$Player/PlayerStack
onready var oponent_stack:CardStack=$OponentStack
onready var table:CardStack=$Table

var dealer

func _enter_tree():
	randomize()

func _ready():
	$Player.table=table
	dealer=Dealer.new(deck)
	dealer.deal(player_stack, oponent_stack, table)

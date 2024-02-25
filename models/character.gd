class_name Character extends Node

var character_name: String
var atk: int
var defense: int
var hp: int
var mp: int

func _init(character_name: String, atk: int, defense: int, hp: int, mp: int):
	self.character_name=character_name
	self.atk = atk
	self.defense = defense
	self.hp = hp
	self.mp = mp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

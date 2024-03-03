extends Node2D

var scenePreload = preload("res://alpha 1.0/enemy a1.0.tscn");

var atk: int;
var def: int;
var agi: int;
var hp: int;
var mp: int;
var node: Node2D;

func _init(atk: int, def: int, agi: int, hp: int, mp: int):
	self.atk = atk;
	self.def = def;
	self.agi = agi;
	self.hp = hp;
	self.mp = mp;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

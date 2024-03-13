extends Node

const BLUE_SQUARE = preload("res://alpha 2.0/animated_sprites/blue_square.tscn");
const CHARACTER_BASE = preload("res://alpha 2.0/models/character_base.tscn");
const Spell = preload("res://alpha 2.0/scripts/spell.gd");

var hp: int;
var maxHp: int;
var agi: int;
var def: int;

var atb: int = 0;


var node: Node2D;

var spells: Array[Spell] = [];

var atbTimer = Timer.new();

func _init(maxHp: int, agi: int, def: int):
	self.maxHp = maxHp;
	self.def = def;
	self.agi = agi;
	node = CHARACTER_BASE.instantiate();
	node.add_child(BLUE_SQUARE.instantiate());
	node.add_child(atbTimer);
	atbTimer.wait_time = 0.1;
	atbTimer.timeout.connect(self._on_atb_timer_timeout);
	atbTimer.autostart = true;

func _on_atb_timer_timeout():
	atb += 1 * agi;

	atb = min(atb, 300);
	atb = max(atb, 0);
	
	self.node.get_node("Atb1").value = 100 if atb >= 100 else atb % 100;
	self.node.get_node("Atb2").value = 100 if atb >= 200 else (atb - 100) % 100;
	self.node.get_node("Atb3").value = 100 if atb == 300 else (atb - 200) % 100;

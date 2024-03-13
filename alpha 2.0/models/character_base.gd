class_name CharacterBase20
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


const BLUE_SQUARE = preload("res://alpha 2.0/animated_sprites/blue_square.tscn");
const Spell = preload("res://alpha 2.0/scripts/spell.gd");

var hp: int;
var maxHp: int;
var agi: int;
var def: int;

var atb: int = 0;

var spells: Array[Spell] = [];

var atbTimer = Timer.new();

func init(maxHp: int, agi: int, def: int):
	self.maxHp = maxHp;
	self.def = def;
	self.agi = agi;
	self.add_child(BLUE_SQUARE.instantiate());
	self.add_child(atbTimer);
	atbTimer.wait_time = 0.1;
	atbTimer.timeout.connect(self._on_atb_timer_timeout);
	atbTimer.autostart = true;

func _on_atb_timer_timeout():
	atb += 1 * agi;

	atb = min(atb, 300);
	atb = max(atb, 0);
	
	self.get_node("Atb1").value = 100 if atb >= 100 else atb % 100;
	self.get_node("Atb2").value = 100 if atb >= 200 else (atb - 100) % 100;
	self.get_node("Atb3").value = 100 if atb == 300 else (atb - 200) % 100;


func getWidth():
	var children = self.get_children();
	for child in children:
		print(child.get_class());
	var box = self.get_node("AnimatedSprite2D/HurtBox/CollisionShape2D");
	return box.shape.size.x * 10;

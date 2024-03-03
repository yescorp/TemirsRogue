extends Node2D

const scenePreload = preload("res://alpha 1.0/character a1.0.tscn");
const arrowPreload = preload("res://arrow.gd");

const Enemy = preload("res://alpha 1.0/enemy a1.0.gd");


var atk: int;
var def: int;
var agi: int;
var hp: int;
var mp: int;
var index: int;
var node: Node2D;
var atb = 100;
var animatedSprite;
var isAttacking: bool = false;
var isPreparingAttack: bool = false;
var preparingAttackIndex: int;

func _init(atk: int, def: int, agi: int, hp: int, mp: int, index: int, animatedSprite):
	self.atk = atk;
	self.def = def;
	self.agi = agi;
	self.hp = hp;
	self.mp = mp;
	self.index = index;
	self.animatedSprite = animatedSprite;


func setup():
	node.add_child(self.animatedSprite);
	node.get_node("Timer").timeout.connect(_on_timer_timeout);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	advanceTimer();
	node.get_node("ProgressBar").value = atb;

func advanceTimer():
	if self.isAttacking:
		return;

	var temp = atb + self.agi * 1;
	if temp > 100:
		temp = 100;
	atb = temp;

func _firstAttack(enemy: Enemy):
	isAttacking = true;
	atb -= 33;
	self.animatedSprite.stop();
	self.animatedSprite.animation_looped.connect(finishAttack.bind(enemy))
	self.animatedSprite.play("Attack");

func attack(enemy: Enemy):
	if !isPreparingAttack:
		return;
		
	isPreparingAttack = false;
	
	if self.preparingAttackIndex == 0:
		_firstAttack(enemy);


func prepareAttack(index: int):
	if atb > 33 and !isAttacking:
		self.preparingAttackIndex = index;
		self.isPreparingAttack = true;
		self.animatedSprite.play("AttackPreparation");


func cancelAttackPreparation():
	if self.isPreparingAttack:
		self.animatedSprite.play("Idle");
		self.isPreparingAttack = false;


func finishAttack(enemy: Enemy):
	var arrow = arrowPreload.new(self);
	var location = animatedSprite.get_node("ArrowLocation");
	arrow.global_position = location.global_position;
	node.add_child(arrow.node);
	arrow.setup();
	animatedSprite.animation_looped.disconnect(finishAttack);
	animatedSprite.play("Idle");
	self.isAttacking = false;
	


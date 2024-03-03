extends AnimatedSprite2D

const Character = preload("res://alpha 1.0/character a1.0.gd");
const scenePreload = preload("res://arrow.tscn");

var character: Character;
var node;

func _init(character: Character):
	self.character = character;
	node = scenePreload.instantiate();

func setup():
	var timer: Timer = node.get_node("Timer");
	timer.start();
	timer.timeout.connect(_on_timer_timeout);
	var area2D: Area2D = node.get_node("Area2D");
	area2D.area_entered.connect(_on_area_2d_area_entered);



func _on_area_2d_area_entered(area):
	node.get_parent().remove_child(node);


func _on_timer_timeout():
	self.node.position = self.node.position + Vector2(20, 0);

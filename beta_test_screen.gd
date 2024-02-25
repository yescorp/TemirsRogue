extends Node2D

const Character = preload("res://models/character.gd")

var selected_enemy: Character = null;
@onready var character = get_node("Character");

# Called when the node enters the scene tree for the first time.
func _ready():
	self.selected_enemy = null;


func _on_attack_button_pressed():
	if selected_enemy != null:
		selected_enemy.hp -= character.character.atk;
		print(selected_enemy.hp)

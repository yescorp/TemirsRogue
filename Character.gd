extends CharacterBody2D

const Character = preload("res://models/character.gd")
var character = Character.new("character", 2, 10, 10, 5);

@onready var ui_selected = get_node("ui_selected");
@onready var battle_node = get_node("/root/beta_test_screen");

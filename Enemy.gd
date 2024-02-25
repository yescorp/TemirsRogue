extends CharacterBody2D

const Character = preload("res://models/character.gd")
var enemy = Character.new("enemy", 2, 10, 10, 5);

@onready var ui_selected = get_node("ui_selected");
@onready var battle_node = get_node("/root/beta_test_screen");
@onready var label = get_node("Label");

func _process(delta):
	label.text = "HP: {hp}\nATK: {atk}\nDEF: {def}\nMP: {mp}".format({"hp": enemy.hp, "atk": enemy.atk, "def": enemy.defense, "mp": enemy.mp});

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			ui_selected.visible = true;
			battle_node.selected_enemy = enemy;

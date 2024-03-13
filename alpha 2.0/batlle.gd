extends Node2D

#const Character = preload("res://alpha 2.0/scripts/character.gd");
const CharacterBase20 = preload("res://alpha 2.0/models/character_base.tscn");

var characters: Array[CharacterBase20] = [CharacterBase20.instantiate(), CharacterBase20.instantiate(), CharacterBase20.instantiate()]

# Called when the node enters the scene tree for the first time.
func _ready():
	var accumulatedWidth = 200;
	for character in self.characters:
		var centerPosition = $BattleCenterPosition.position;
		character.init(50, 2, 10);
		character.position = centerPosition + Vector2(-accumulatedWidth, 0);
		accumulatedWidth += character.getWidth();
		self.add_child(character);


func _input(event):
	#if event.is_action_pressed("change_character"):
		#var nextIndex = getNextCharacterIndex();
		#selectCharacter(nextIndex);
	if event.is_action_pressed("ui_cancel"):
		#for child in characters:
			#self.get_parent().remove_child(child.node);
		#for child in enemies:
			#self.get_parent().remove_child(child.node);
		get_tree().change_scene_to_file("res://main.tscn");
	#if event.is_action_pressed("first_attack"):
		#firstAttack();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

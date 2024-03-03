extends Node2D

const CHARACTER_OFFSET_FROM_CENTER: int = 100;
const C1_PRELOAD = preload("res://alpha 1.0/character a1.0.tscn");
const E1_PRELOAD = preload("res://alpha 1.0/enemy a1.0.tscn");

const ArcherRedAnimatedSprite = preload("res://archer_red_animated_sprite.tscn");
const ArcherBlueAnimatedSprite = preload("res://archer_blue_animated_sprite.tscn");
const ArcherPurpleAnimatedSprite = preload("res://archer_purple_animated_sprite.tscn");

const Character = preload("res://alpha 1.0/character a1.0.gd");
const Enemy = preload("res://alpha 1.0/enemy a1.0.gd");

const CharacterPreloads = [C1_PRELOAD, E1_PRELOAD];

var characters: Array[Character] = [
	Character.new(10, 0, 2, 50, 10, 0, ArcherRedAnimatedSprite.instantiate()),
	Character.new(20, 0, 2, 10, 0, 1, ArcherBlueAnimatedSprite.instantiate()),
	Character.new(5, 0, 3, 40, 2, 2, ArcherPurpleAnimatedSprite.instantiate())
];


var enemies: Array[Enemy] = [
	Enemy.new(10, 0, 1, 50, 10),
	Enemy.new(20, 0, 1, 10, 0),
	Enemy.new(5, 0, 3, 40, 2)
];

var selectedCharacter = characters[2];
var selectedEnemy = enemies[0];

func _add_characters(centerPosition: Vector2):
	var accumulatedCharacterWidth: int = 0;
	for character in characters:
		var node = character.scenePreload.instantiate();
		
		# draw character
		node.set_position(centerPosition + Vector2(-CHARACTER_OFFSET_FROM_CENTER - accumulatedCharacterWidth, 0));
		
		#add accumulated width
		var shape = node.get_node("Area2D/CollisionShape2D");
		accumulatedCharacterWidth += shape.shape.size.x * 2;
		character.node = node;
		
		# set hp
		var hpLabelOnCharacter: Label = node.get_node("HP");
		hpLabelOnCharacter.text = str(character.hp);
		
		# setup
		var area2D: Area2D = node.get_node("Area2D")
		area2D.input_event.connect(character_selected.bind(character));
		character.setup();
		self.get_parent().add_child(node);


func _add_enemies(centerPosition: Vector2):
	var accumulatedEnemyWidth: int = 0;
	for enemy in enemies:
		var node = enemy.scenePreload.instantiate();
		node.set_position(centerPosition + Vector2(CHARACTER_OFFSET_FROM_CENTER + accumulatedEnemyWidth, 0));
		var shape = node.get_node("Area2D/CollisionShape2D");
		accumulatedEnemyWidth += shape.shape.size.x * 2;
		enemy.node = node;
		var hpLabelOnEnemy: Label = node.get_node("HP");
		hpLabelOnEnemy.text = str(enemy.hp);
		
		var area2D: Area2D = node.get_node("Area2D")
		area2D.input_event.connect(enemy_selected.bind(enemy));
		
		self.get_parent().add_child(node);


func character_selected(viewport: Node, event: InputEvent, shape_idx: int, character):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var prevSelected:CanvasGroup = selectedCharacter.node.get_node("Selected");
			prevSelected.visible = false;
			selectedCharacter = character;
			var selected:CanvasGroup = selectedCharacter.node.get_node("Selected");
			selected.visible = true;
			setSelectedCharacterProperties();

func enemy_selected(viewport: Node, event: InputEvent, shape_idx: int, enemy):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if selectedCharacter.isPreparingAttack:
				selectedCharacter.attack(enemy);


func selectCharacter(index: int):
	var prevSelected:CanvasGroup = selectedCharacter.node.get_node("Selected");
	prevSelected.visible = false;
	selectedCharacter.cancelAttackPreparation();
	selectedCharacter = characters[index];
	var selected:CanvasGroup = selectedCharacter.node.get_node("Selected");
	selected.visible = true;
	setSelectedCharacterProperties();


func setSelectedCharacterProperties():
	$SelectedCharacterStats/HpValue.text = str(selectedCharacter.hp);
	$SelectedCharacterStats/DefValue.text = str(selectedCharacter.def);
	$SelectedCharacterStats/MpValue.text = str(selectedCharacter.mp);
	$SelectedCharacterStats/AgiValue.text = str(selectedCharacter.agi);
	$SelectedCharacterStats/AtkValue.text = str(selectedCharacter.atk);



func setSelectedEnemyProperties():
	$SelectedEnemyStats/HpValue.text = str(selectedEnemy.hp);
	$SelectedEnemyStats/DefValue.text = str(selectedEnemy.def);
	$SelectedEnemyStats/MpValue.text = str(selectedEnemy.mp);
	$SelectedEnemyStats/AgiValue.text = str(selectedEnemy.agi);
	$SelectedEnemyStats/AtkValue.text = str(selectedEnemy.atk);


# Called when the node enters the scene tree for the first time.
func _ready():
	var centerPosition: Vector2 = $BattleCenterPosition.global_position;
	_add_characters(centerPosition);
	_add_enemies(centerPosition);
	selectCharacter(2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event.is_action_pressed("change_character"):
		var nextIndex = getNextCharacterIndex();
		selectCharacter(nextIndex);
	if event.is_action_pressed("ui_cancel"):
		for child in characters:
			self.get_parent().remove_child(child.node);
		for child in enemies:
			self.get_parent().remove_child(child.node);
		get_tree().change_scene_to_file("res://main.tscn");
	if event.is_action_pressed("first_attack"):
		firstAttack();

func getNextCharacterIndex():
	var index = selectedCharacter.index;
	var length = characters.size();
	if index > 0:
		return index - 1;
	else:
		return length - 1;


func firstAttack():
	selectedCharacter.prepareAttack(0);


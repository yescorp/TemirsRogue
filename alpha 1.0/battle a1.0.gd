extends Node2D

const CHARACTER_OFFSET_FROM_CENTER: int = 100;
const C1_PRELOAD = preload("res://alpha 1.0/character a1.0.tscn");
const E1_PRELOAD = preload("res://alpha 1.0/enemy a1.0.tscn");

const CharacterPreloads = [C1_PRELOAD, E1_PRELOAD];

var characters = [
	{
		"resourceId": 0,
		"name": "C1",
		"atk": 10,
		"hp": 50,
		"def": 20,
		"mp": 0,
		"agi": 5
	},
	{
		"resourceId": 0,
		"name": "C2",
		"atk": 10,
		"hp": 50,
		"def": 20,
		"mp": 0,
		"agi": 5
	},
	{
		"resourceId": 0,
		"name": "C3",
		"atk": 10,
		"hp": 50,
		"def": 20,
		"mp": 0,
		"agi": 5
	}
];


var enemies = [
	{
		"resourceId": 1,
		"name": "E1",
		"atk": 10,
		"hp": 50,
		"def": 20,
		"mp": 0,
		"agi": 5
	},
	{
		"resourceId": 1,
		"name": "E2",
		"atk": 10,
		"hp": 50,
		"def": 20,
		"mp": 0,
		"agi": 5
	},
	{
		"resourceId": 1,
		"name": "E3",
		"atk": 10,
		"hp": 50,
		"def": 20,
		"mp": 0,
		"agi": 5
	}
];

var selectedCharacter = characters[0];
var selectedEnemy = enemies[0];

func _add_characters(centerPosition: Vector2):
	var accumulatedCharacterWidth: int = 0;
	for character in characters:
		var node = self.CharacterPreloads[character["resourceId"]].instantiate();
		
		# draw character
		node.set_position(centerPosition + Vector2(-CHARACTER_OFFSET_FROM_CENTER - accumulatedCharacterWidth, 0));
		
		#add accumulated width
		var shape = node.get_node("Area2D/CollisionShape2D");
		accumulatedCharacterWidth += shape.shape.size.x * 2;
		character["node"] = node;
		
		# set hp
		var hpLabelOnCharacter: Label = node.get_node("HP");
		hpLabelOnCharacter.text = str(character["hp"]);
		
		# setup
		var area2D: Area2D = node.get_node("Area2D")
		area2D.input_event.connect(character_selected.bind(character));
		self.get_parent().add_child(node);


func _add_enemies(centerPosition: Vector2):
	var accumulatedEnemyWidth: int = 0;
	for enemy in enemies:
		var node = self.CharacterPreloads[enemy["resourceId"]].instantiate();
		node.set_position(centerPosition + Vector2(CHARACTER_OFFSET_FROM_CENTER + accumulatedEnemyWidth, 0));
		var shape = node.get_node("Area2D/CollisionShape2D");
		accumulatedEnemyWidth += shape.shape.size.x * 2;
		enemy["node"] = node;
		var hpLabelOnEnemy: Label = node.get_node("HP");
		hpLabelOnEnemy.text = str(enemy["hp"]);
		
		var area2D: Area2D = node.get_node("Area2D")
		area2D.input_event.connect(enemy_selected.bind(enemy));
		
		self.get_parent().add_child(node);


func character_selected(viewport: Node, event: InputEvent, shape_idx: int, character):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var prevSelected:CanvasGroup = selectedCharacter["node"].get_node("Selected");
			prevSelected.visible = false;
			selectedCharacter = character;
			var selected:CanvasGroup = selectedCharacter["node"].get_node("Selected");
			selected.visible = true;
			setSelectedCharacterProperties();

func enemy_selected(viewport: Node, event: InputEvent, shape_idx: int, enemy):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var prevSelected:CanvasGroup = selectedEnemy["node"].get_node("Selected");
			prevSelected.visible = false;
			selectedEnemy = enemy;
			var selected:CanvasGroup = selectedEnemy["node"].get_node("Selected");
			selected.visible = true;
			setSelectedEnemyProperties();


func setSelectedCharacterProperties():
	$SelectedCharacterStats/HpValue.text = str(selectedCharacter["hp"]);
	$SelectedCharacterStats/DefValue.text = str(selectedCharacter["def"]);
	$SelectedCharacterStats/MpValue.text = str(selectedCharacter["mp"]);
	$SelectedCharacterStats/AgiValue.text = str(selectedCharacter["agi"]);
	$SelectedCharacterStats/AtkValue.text = str(selectedCharacter["atk"]);



func setSelectedEnemyProperties():
	$SelectedEnemyStats/HpValue.text = str(selectedEnemy["hp"]);
	$SelectedEnemyStats/DefValue.text = str(selectedEnemy["def"]);
	$SelectedEnemyStats/MpValue.text = str(selectedEnemy["mp"]);
	$SelectedEnemyStats/AgiValue.text = str(selectedEnemy["agi"]);
	$SelectedEnemyStats/AtkValue.text = str(selectedEnemy["atk"]);


# Called when the node enters the scene tree for the first time.
func _ready():
	var centerPosition: Vector2 = $BattleCenterPosition.global_position;
	_add_characters(centerPosition);
	_add_enemies(centerPosition);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_attack_button_pressed():
	var animatedSprite :AnimatedSprite2D = selectedCharacter.node.get_node("AnimatedSprite2D");
	animatedSprite.stop();
	animatedSprite.animation_looped.connect(finish_attack.bind(selectedCharacter))
	animatedSprite.play("Attack");


func finish_attack(character):
	var animatedSprite: AnimatedSprite2D = character.node.get_node("AnimatedSprite2D");
	animatedSprite.animation_looped.disconnect(finish_attack)
	animatedSprite.play("Idle");

extends Node2D

const C1_PRELOAD = preload("res://alpha 1.0/character a1.0.tscn");

const CharacterPreloads = [C1_PRELOAD];

var characters = [
	{
		"resourceId": 0,
		"name": "C1",
		"atk": 10,
		"hp": 50,
		"def": 20,
		"mp": 0
	},
	{
		"resourceId": 0,
		"name": "C2",
		"atk": 10,
		"hp": 50,
		"def": 20,
		"mp": 0
	},
	{
		"resourceId": 0,
		"name": "C3",
		"atk": 10,
		"hp": 50,
		"def": 20,
		"mp": 0
	}
];

const CHARACTER_OFFSET_FROM_CENTER: int = 100;

# Called when the node enters the scene tree for the first time.
func _ready():
	var centerPosition: Vector2 = $BattleCenterPosition.global_position;
	
	var accumulatedCharacterWidth: int = 0;
	for character in characters:
		var node = self.CharacterPreloads[0].instantiate();
		node.set_position(centerPosition + Vector2(-CHARACTER_OFFSET_FROM_CENTER - accumulatedCharacterWidth, 0));
		var characterShape = node.get_node("Area2D/CollisionShape2D");
		accumulatedCharacterWidth += characterShape.shape.size.x;
		self.get_parent().add_child(node);

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

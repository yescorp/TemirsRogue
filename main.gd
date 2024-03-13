extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_test_pressed():
	var tree = get_tree();
	tree.change_scene_to_file("res://alpha 1.0/battle a1.0.tscn")


func _on_play_alpha_2_0_pressed():
	var tree = get_tree();
	tree.change_scene_to_file("res://alpha 2.0/batlle.tscn");

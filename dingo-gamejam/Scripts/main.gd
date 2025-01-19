extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()


func _on_vine_won() -> void:
	get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")


func _on_water_death() -> void:
	print_debug("Got here")
	get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")

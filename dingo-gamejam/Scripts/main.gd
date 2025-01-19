extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()

func _on_vine_won() -> void:
	get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")

extends Control

@onready var animator: AnimationPlayer = $AnimationPlayer

signal grown(cost: float)
signal won

func _on_growth_grow(current_growth, growth_cost) -> void:
	animator.play(str(current_growth))
	grown.emit(growth_cost)

func _on_growth_win() -> void:
	won.emit()

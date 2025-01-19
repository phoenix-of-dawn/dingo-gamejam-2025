extends Control

@onready var sprite: Sprite2D = $VineSprite

signal grown(cost: float)
signal won

func _on_growth_grow(current_growth, growth_cost) -> void:
	sprite.frame = current_growth
	grown.emit(growth_cost)

func _on_growth_win() -> void:
	won.emit()

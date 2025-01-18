extends Button

@export var cost: int
@export var repeatable: bool

signal up_purchased(cost)

func _on_pressed() -> void:
	if not repeatable:
		disabled = true
	up_purchased.emit(cost)

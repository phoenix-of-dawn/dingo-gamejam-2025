extends Button

@export var cost: int
@export var repeatable: bool

signal up_purchased(cost)

func _on_pressed() -> void:
	if get_parent().nutrients >= cost:
		if not repeatable: 
			disabled = true
		up_purchased.emit(cost)

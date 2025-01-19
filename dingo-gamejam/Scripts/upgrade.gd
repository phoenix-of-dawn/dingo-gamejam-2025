extends Button

@export var up_name: String
@export var cost: float
@export var repeatable: bool
@export var nutrients_per_second: float
@export var cost_increase: float

var amount: int = 1

signal up_purchased(cost, nutrients_per_second)

func _on_pressed() -> void:
	if get_parent().get_parent().get_parent().nutrients >= cost + (cost_increase)**amount:
		up_purchased.emit(cost + (cost_increase)**amount, nutrients_per_second)
		
		if not repeatable:
			disabled = true
		amount += 1
		update_button()
	else:
		$AnimationPlayer.play("error")

func update_button() -> void:
	text = up_name + "\nCost: " + str(cost + (cost_increase)**amount) + "\nAmount: " + str(amount - 1)

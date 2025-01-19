extends Button

var growth_costs: Array = [100, 200, 500, 1000, 5000, 20000, 50000, 100000, 150000, 250000, 500000, 750000, 1000000]
var growth_cost = growth_costs[0]
var current_growth = 0

signal grow(current_growth: int, growth_cost: float)
signal win

func _ready() -> void:
	text = "Cost to next growth: " + str(growth_costs[0])

func _on_pressed() -> void:
	var nutrients = get_parent().get_parent().get_node("Nutrients").nutrients
	if nutrients >= growth_cost:
		nutrients -= growth_cost
		current_growth += 1
		if current_growth >= len(growth_costs):
			win.emit()
		else:
			grow.emit(current_growth, growth_cost)
			growth_cost = growth_costs[current_growth]
			text = "Cost to next growth: " + str(growth_costs[current_growth])

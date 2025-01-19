extends Button

var growth_costs: Array = [
	100, 
	200, 
	500, 
	1000, 
	5000, 
	20000, 
	50000, 
	100000, 
	150000, 
	250000, 
	500000, 
	750000, 
	1000000, 
	1250000, 
	2000000,
]
var growth_names: Array = [
	"A Bud Sprouts", 
	"Taking Over", 
	"Do You Know the Definition of Insanity?", 
	"Tear Down the Wall", 
	"World, Here I Come!", 
	"The Takeover", 
	"Home Sweet Home!", 
	"Tick Tock!", 
	"We can't live here, huh", 
	"💀", 
	"The Boogie", 
	"The Cabbage of Doom", 
	"The Start of The End", 
	"I am Death", 
	"The Destroyer of Worlds",
]
var growth_cost = growth_costs[0]
var current_growth = 1

signal grow(current_growth: int, growth_cost: float)
signal win

func _ready() -> void:
	text = str(growth_names[current_growth - 1]) + "\nCost: " + str(growth_cost)

func _on_pressed() -> void:
	var nutrients = get_parent().get_parent().get_node("Nutrients").nutrients
	if nutrients >= growth_cost:
		nutrients -= growth_cost
		current_growth += 1
		if current_growth - 1 >= len(growth_costs):
			win.emit()
		else:
			grow.emit(current_growth, growth_cost)
			growth_cost = growth_costs[current_growth - 1]
			text = str(growth_names[current_growth - 1]) + "\nCost: " + str(growth_cost)

extends Control

@export var nutrients: float = 5.0
var nutrients_per_second: float = 0.0

@onready var text = $NutrientCount
@onready var upgrade_template = preload("res://Scenes/upgrade.tscn")

var upgrades: Dictionary = {
	"Photosynthesis": [5.0, false, 0.2, 0],
	"Chlorophyl": [7.5, true, 0.5, 2],
	"Vine Strength": [30.0, true, 2.0 , 3],
	"Vine Girth": [100.0, true, 4.0 , 4],
	"Vine Hardness": [400.0, true, 20.0 , 5],
	"Iron Surplus+": [4000.0, false, 150.0, 0]
}

func _ready() -> void:
	text.position.x = size.x / 2 - text.size.x / 2
	make_buttons()

func _process(_delta: float) -> void:
	text.text = "Nutrients: " + str(nutrients)

func make_buttons():
	var up_position = 60
	for up_name in upgrades:
		var button: Button = upgrade_template.instantiate()
		button.position.x = size.x / 2 - button.size.x / 2
		button.position.y = up_position
		button.up_name = up_name
		button.text = up_name + "\nCost: " + str(upgrades[up_name][0])
		button.cost = upgrades[up_name][0]
		button.repeatable = upgrades[up_name][1]
		button.nutrients_per_second = upgrades[up_name][2]
		button.cost_increase = upgrades[up_name][3]
		button.up_purchased.connect(_update_nutrients)
		add_child(button)
		up_position += button.size.y + 2

func _update_nutrients(cost, up_nutrients_per_second): 
	nutrients -= cost
	nutrients_per_second += snappedf(up_nutrients_per_second, 0.1)


func _on_nutrient_countdown_timeout() -> void:
	nutrients = snappedf(nutrients + nutrients_per_second, 0.1)

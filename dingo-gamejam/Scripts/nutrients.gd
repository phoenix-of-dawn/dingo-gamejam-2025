extends Control

@export var nutrients: float = 10
var nutrients_per_second: float = 0.0
@onready var nut_text = $NutrientCount
@onready var nut_per_sec_text = %NutrientPerSecond
@onready var scroll_cont = $ScrollContainer
@onready var button_cont = %Buttons
@onready var upgrade_template = preload("res://Scenes/upgrade.tscn")

var upgrades: Dictionary = {
	"Photosynthesis": [10.0, false, 1, 0],
	"Chlorophyl": [30.0, true, 1.5, 2.0],
	"Vine Strength": [100.0, true, 5.0, 3.0],
	"Vine Girth": [300.0, true, 15.0, 4.0],
	"Vine Hardness": [1000.0, true, 40.0, 5.0],
	"Iron Surplus+": [2500.0, false, 100.0, 0],
	"Steroids": [5000.0, true, 200.0, 7.0],
	"Fat Deposits": [12000.0, true, 400.0, 8.0],
	"Fatter Deposits": [25000.0, true, 800.0, 9.0],
	"Iron Surplus++": [50000.0, false, 1500.0, 0],
	"Expired Milk": [75000.0, true, 2500.0, 12.0],

	"Expired Milk 2.0": [100000.0, true, 4000.0, 15.0],
	"Banana Shake": [150000.0, true, 6000.0, 18.0],
	"Chlorophyll Synthesis": [250000.0, true, 10000.0, 20.0],
	"Root Network": [400000.0, true, 20000.0, 25.0],
	"Sunlight Absorption": [750000.0, true, 30000.0, 30.0],
	"Nutrient Circulation": [1200000.0, true, 50000.0, 40.0],
	"Mineral Extraction": [2000000.0, true, 80000.0, 50.0],
	"Vine Resilience": [3000000.0, true, 150000.0, 60.0],
	"Photosynthesis Amplifier": [5000000.0, true, 300000.0, 75.0],
	"Plant Hormones": [8000000.0, true, 500000.0, 100.0],
	"Vine Fortress": [12000000.0, true, 800000.0, 150.0],
	"Carbon Conversion Core": [20000000.0, true, 1200000.0, 200.0],
	"Nutrient Hyperstorage": [40000000.0, true, 2000000.0, 300.0],
	"Synthetic Nutrients": [60000000.0, true, 3000000.0, 500.0],
	"Ironroot Reinforcement": [100000000.0, true, 5000000.0, 700.0],
	"Nanoparticles in Soil": [150000000.0, true, 8000000.0, 900.0],
	"Nutrient Harvester+": [300000000.0, true, 15000000.0, 1200.0],
	"Biotech Enhancement": [500000000.0, true, 25000000.0, 1500.0],
	"Tsar Bomba": [1000000000.0, true, 40000000.0, 2000.0],
	"How did we get here?": [2000000000.0, true, 60000000.0, 3000.0]
}



func _ready() -> void:
	scroll_cont.position.y = nut_text.size.y + nut_per_sec_text.size.y + nut_text.position.y - 10
	scroll_cont.size.y = 1000 - nut_text.size.y + nut_per_sec_text.size.y + nut_text.position.y
	scroll_cont.size.x = 250

	scroll_cont.position.x = size.x / 2 - scroll_cont.size.x / 2
	make_buttons()

func _process(_delta: float) -> void:
	nut_text.text = "Nutrients: " + str(nutrients)
	nut_per_sec_text.text = "Nutrients/s: " + str(nutrients_per_second)

func make_buttons() -> void:
	var up_position = nut_text.size.y + nut_per_sec_text.size.y + nut_text.position.y - 10
	for up_name in upgrades:
		var button: Button = upgrade_template.instantiate()
		button.position.x = size.x / 2 - button.size.x / 2
		button.position.y = up_position
		button.up_name = up_name
		button.text = up_name + "\nCost: " + str(upgrades[up_name][0]) + "\nAmount: 0"
		button.cost = upgrades[up_name][0]
		button.repeatable = upgrades[up_name][1]
		button.nutrients_per_second = upgrades[up_name][2]
		button.cost_increase = upgrades[up_name][3]
		button.up_purchased.connect(_update_nutrients)
		button_cont.add_child(button)
		up_position += button.size.y + 2

func _update_nutrients(cost, up_nutrients_per_second) -> void: 
	nutrients = snappedf(nutrients - cost, 0.01)
	nutrients_per_second += snappedf(up_nutrients_per_second, 0.01)

func _on_nutrient_countdown_timeout() -> void:
	nutrients = snappedf(nutrients + nutrients_per_second, 0.01)


func _on_vine_grown(cost: float) -> void:
	nutrients -= cost


func _on_water_refill() -> void:
	nutrients *= 0.5

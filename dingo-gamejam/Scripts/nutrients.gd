extends Control

@export var nutrients: float = 10000000
var nutrients_per_second: float = 0.0

@onready var nut_text = $NutrientCount
@onready var nut_per_sec_text = %NutrientPerSecond
@onready var scroll_cont = $ScrollContainer
@onready var button_cont = %Buttons
@onready var upgrade_template = preload("res://Scenes/upgrade.tscn")

var upgrades: Dictionary = {
	"Photosynthesis": [2.5, false, 0.25, 0],
	"Chlorophyl": [5.0, true, 0.75, 0.5],
	"Vine Strength": [30.0, true, 2.0 , 3],
	"Vine Girth": [100.0, true, 4.0 , 4],
	"Vine Hardness": [400.0, true, 20.0 , 5],
	"Iron Surplus+": [4000.0, false, 150.0, 0],
	"Steroids": [6000.0, true, 80.0, 6],
	"Fat Deposits": [10000.0, true, 100.0, 7],
	"Fatter Deposits": [15000.0, true, 140.0, 8],
	"Iron Surplus++": [30000.0, false, 400.0, 0],
	"Expired Milk": [40000.0, true, 200.0, 11],
	
}

func _ready() -> void:
	scroll_cont.position.y = nut_text.size.y + nut_per_sec_text.size.y + nut_text.position.y - 10
	scroll_cont.size.y = 1000 - nut_text.size.y + nut_per_sec_text.size.y + nut_text.position.y
	scroll_cont.size.x = 210

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

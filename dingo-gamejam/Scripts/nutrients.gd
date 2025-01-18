extends Control

@export var nutrients: int = 10
@onready var text = $NutrientCount
@onready var upgrade_template = preload("res://Scenes/upgrade.tscn")

var upgrades: Dictionary = {
	"Photosynthesis": [10.0, false],
	"Chlorophyl": [20.0, true],
	"Vine Strength": [30.0, true]
}

func _ready() -> void:
	text.position.x = size.x / 2 - text.size.x / 2
	make_buttons()

func _process(delta: float) -> void:
	text.text = "Nutrients: " + str(nutrients)

func make_buttons():
	var position = 60
	for name in upgrades:
		var button: Button = upgrade_template.instantiate()
		button.position.x = size.x / 2 - button.size.x / 2
		button.position.y = position
		button.text = name + "\nCost: " + str(upgrades[name][0])
		button.cost = upgrades[name][0]
		button.repeatable = upgrades[name][1]
		button.up_purchased.connect(_update_nutrients)
		add_child(button)
		position += button.size.y + 2

func _update_nutrients(cost): 
	if nutrients >= cost:
		nutrients -= cost

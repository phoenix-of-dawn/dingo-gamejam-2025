extends Control

@onready var water_progress = $ProgressBar
@onready var button = $Refill

signal refill()
var refill_uses = 3

func _ready() -> void:
	update_button()

func _on_timer_timeout() -> void:
	water_progress.value -= 1


func _on_vine_grown(_cost: float) -> void:
	water_progress.value = 100
	refill_uses = 3
	update_button()


func _on_refill_pressed() -> void:
	water_progress.value = 100
	refill_uses -= 1
	update_button()
	if refill_uses <= 0:
		button.disabled = true
	refill.emit()

func update_button() -> void:
	button.text = "Refill\n" + "Cost: 50%\n" + "Refills: " + str(refill_uses)

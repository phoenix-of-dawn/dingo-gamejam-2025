extends Control

@onready var water_progress = $ProgressBar

func _on_timer_timeout() -> void:
	water_progress.value -= 1


func _on_vine_grown(cost: float) -> void:
	water_progress.value = 100

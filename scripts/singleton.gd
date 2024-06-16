extends Node


# Global variables
var shipping := true
var ship_display: SubViewportContainer
var switch_cooldown: Timer
var resources := 10


func switch_shipping() -> void:
	if switch_cooldown.is_stopped():
		shipping = not shipping
		if shipping:
			ship_display.modulate = Color.WHITE
		else:
			ship_display.modulate = Color.TRANSPARENT
		switch_cooldown.start()


func decrease_resources() -> void:
	resources -= 1

extends Node


@onready var timer = $Timer

@export var curve: Curve
var current_index := 0.0


func _enter_tree():
	Singleton.damage_curve = self


func _ready():
	timer.start()


func _on_timer_timeout():
	Singleton.generate_damage()
	print(timer.wait_time)
	if current_index >= 1:
		timer.wait_time = curve.sample_baked(1)
	else:
		timer.wait_time = curve.sample_baked(current_index)
		current_index += 1

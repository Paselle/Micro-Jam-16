extends Timer


const ASTEROID = preload("res://scenes/asteroid.tscn")
const SPAWN_DISTANCE = 1500

@export var curve: Curve
var current_index := 0.0


func _on_timeout():
	var new_asteroid = ASTEROID.instantiate()
	new_asteroid.global_position = Vector3(randf() - 0.499, randf() - 0.499, randf() - 0.499) * SPAWN_DISTANCE + get_parent().global_position
	Singleton.flying_ship_root.add_child(new_asteroid)
	if current_index >= 1:
		wait_time = curve.sample_baked(1)
	else:
		wait_time = curve.sample_baked(current_index)
		current_index += 0.01

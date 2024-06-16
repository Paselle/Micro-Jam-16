extends Timer


const SCRAP = preload("res://scenes/scrap.tscn")
const SPAWN_DISTANCE = 150

@export var curve: Curve
var current_index := 0.0


func _on_timeout():
	var new_scrap = SCRAP.instantiate()
	new_scrap.global_position = Vector3(randf() - 0.499, randf() - 0.499, randf() - 0.499) * SPAWN_DISTANCE + get_parent().global_position
	get_tree().root.add_child(new_scrap)
	if current_index >= 1:
		wait_time = curve.sample_baked(1)
	else:
		wait_time = curve.sample_baked(current_index)
		current_index += 0.01

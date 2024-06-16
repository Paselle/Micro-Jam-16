extends Node


const REPAIR_THING = preload("res://scenes/repair_thing.tscn")

# Global variables
var shipping := true
var ship_display: SubViewportContainer
var switch_cooldown: Timer
var resources := 10
var damage_curve: Node


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


func generate_damage() -> void:
	var repair_socket = get_tree().get_nodes_in_group("repair_socket").pick_random() as Marker3D
	var new_repair_thing = REPAIR_THING.instantiate()
	get_tree().root.add_child(new_repair_thing)
	print(new_repair_thing.global_basis,"   ",repair_socket.global_basis)
	new_repair_thing.global_basis = repair_socket.global_basis
	print(new_repair_thing.global_basis,"   ",repair_socket.global_basis)

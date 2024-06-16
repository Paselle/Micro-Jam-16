extends Node


const REPAIR_THING = preload("res://scenes/repair_thing.tscn")

# Global variables
var shipping := true
var ship_display: SubViewportContainer
var switch_cooldown: Timer
var resources := 10
var damage_curve: Node
var resource_couter: ResourceCounter
var breaks := 0
var integrity_bar: ProgressBar
var losing_animation: AnimationPlayer
var ship: Ship
var flying_ship_root: Node3D
var audio_thing: AudioThing


func _ready():
	resource_couter.text = resource_couter.initial_text + str(resources)


func switch_shipping() -> void:
	if switch_cooldown.is_stopped():
		shipping = not shipping
		if shipping:
			ship_display.modulate = Color.WHITE
			switch_cooldown.ship_on.play()
		else:
			ship_display.modulate = Color.TRANSPARENT
			switch_cooldown.ship_off.play()
		switch_cooldown.start()


func decrease_resources() -> void:
	resources -= 1
	resource_couter.text = resource_couter.initial_text + str(resources)


func increase_resources() -> void:
	resources += 1
	resource_couter.text = resource_couter.initial_text + str(resources)


func generate_damage() -> void:
	breaks += 1
	if breaks > integrity_bar.max_value:
		losing_animation.play("losing")
	integrity_bar.value = integrity_bar.max_value - breaks
	var repair_socket = get_tree().get_nodes_in_group("repair_socket").pick_random() as Marker3D
	var new_repair_thing = REPAIR_THING.instantiate()
	get_tree().root.add_child(new_repair_thing)
	new_repair_thing.global_position = repair_socket.global_position
	new_repair_thing.rotation = repair_socket.rotation


func damage_removed() -> void:
	breaks -= 1
	integrity_bar.value = integrity_bar.max_value - breaks

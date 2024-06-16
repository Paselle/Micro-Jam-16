class_name RepairThing extends Area3D


const NOISE_TEXTURE_2D = preload("res://resources/noise_texture_2d.tres")
const FAST_NOISE_LITE = preload("res://resources/fast_noise_lite.tres")

@onready var mesh = $Mesh


func _ready():
	mesh.mesh = mesh.mesh.duplicate(true)
	var new_noise_texture = NOISE_TEXTURE_2D.duplicate()
	var new_noise = FAST_NOISE_LITE.duplicate()
	new_noise.seed = randi_range(0, 10000)
	new_noise_texture.noise = new_noise
	mesh.mesh.material.set_shader_parameter("NoiseTexture", new_noise_texture)


func repair() -> void:
	Singleton.decrease_resources()
	Singleton.damage_removed()
	queue_free()

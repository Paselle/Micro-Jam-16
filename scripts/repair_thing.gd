class_name RepairThing extends Area3D


const NOISE_TEXTURE_2D = preload("res://resources/noise_texture_2d.tres")
const FAST_NOISE_LITE = preload("res://resources/fast_noise_lite.tres")

@onready var mesh = $Mesh


func _ready():
	var new_noise_texture = FAST_NOISE_LITE.duplicate()
	new_noise_texture.seed = randi_range(0, 10000)
	mesh.mesh.material.get_shader_parameter("NoiseTexture").noise = new_noise_texture


func repair() -> void:
	Singleton.decrease_resources()
	queue_free()

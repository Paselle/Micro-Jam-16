class_name RepairThing extends Area3D


const NOISE_TEXTURE_2D = preload("res://resources/noise_texture_2d.tres")

@onready var mesh = $Mesh


func _ready():
	var new_noise_texture = NOISE_TEXTURE_2D
	new_noise_texture.noise.seed = randi_range(0, 10000)
	mesh.mesh.material.set_shader_parameter("NoiseTexture", new_noise_texture)


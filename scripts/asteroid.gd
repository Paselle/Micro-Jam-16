extends AnimatableBody3D


var speed: float
var spin_speed: float
var direction: Vector3
var spin_axis: Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	var scale_size = randf_range(1, 10)
	scale = Vector3(scale_size, scale_size, scale_size)
	speed = randf_range(2, 10)
	spin_speed = randf_range(0.5, 2)
	direction = Vector3(randf(), randf(), randf()).normalized()
	spin_axis = Vector3(randf(), randf(), randf()).normalized()


func _physics_process(delta):
	rotate(spin_axis, spin_speed * delta)
	move_and_collide(direction * speed * delta)

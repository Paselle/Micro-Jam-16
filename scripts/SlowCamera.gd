class_name SlowCamera extends Camera3D


var neg = false


func _process(delta):
	var speed = 100 * Singleton.ship.velocity.length() / 10 + 10
	global_position = global_position.move_toward(Singleton.ship.camera_marker.global_position, speed * delta)
	if Singleton.ship.camera_marker.global_rotation_degrees < 0:
		neg = true
	
	if neg:
		global_rotation_degrees = global_rotation_degrees.move_toward(Singleton.ship.camera_marker.global_rotation_degrees + 360, speed * delta / 50)
	else:
		global_rotation_degrees = global_rotation_degrees.move_toward(Singleton.ship.camera_marker.global_rotation_degrees, speed * delta / 50)
	#global_rotation_degrees.x = move_toward(global_rotation_degrees.x - 180, Singleton.ship.camera_marker.global_rotation_degrees.x - 180, speed * delta)
	#global_rotation_degrees.y = move_toward(global_rotation_degrees.y - 180, Singleton.ship.camera_marker.global_rotation_degrees.y - 180, speed * delta)
	#global_rotation_degrees.z = move_toward(global_rotation_degrees.z - 180, Singleton.ship.camera_marker.global_rotation_degrees.z - 180, speed * delta)

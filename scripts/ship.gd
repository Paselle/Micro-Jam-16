class_name Ship extends CharacterBody3D


const ACCEL = 15.0
const DECEL = 1.0
const MAX_SPEED = 500.0
const TURN_SPEED = 100.0
const CRASH_VELOCITY = 20.0
const REBOUND_SPEED = 30.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Get thruster particles
@onready var thrusters_l = $ThrustersL
@onready var thrusters_r = $ThrustersR

# Get the player camera
@onready var marker_3d = $Marker
@onready var camera_marker = $Marker/CameraMarker

# Make the camera variables
var camera_rotation = Vector2(0, 0)
var mouse_sensitivity := 0.003


func _enter_tree():
	Singleton.ship = self


func _ready() -> void:
	# Remove the mouse from the screen and just capture its movement
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event) -> void:
	# If escape is pressed reveal the mouse
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	
	# Thruster particles direction
	thrusters_l.process_material.direction = -velocity.normalized()
	thrusters_r.process_material.direction = -velocity.normalized()
	
	if Singleton.shipping:
		if Input.is_action_just_pressed("switch"):
			Singleton.switch_shipping()
		
		# Accelerate
		if Input.is_action_pressed("thrust"):
			velocity -= basis.z * ACCEL * delta
			thrusters_l.emitting = true
			thrusters_r.emitting = true	
		else:
			thrusters_l.emitting = false
			thrusters_r.emitting = false	
			if	Input.is_action_pressed("brake"):
				velocity = velocity.move_toward(Vector3.ZERO, DECEL)
		
		var input_dir = Input.get_vector("left", "right", "forward", "backward")
		
		rotate_object_local(Vector3(1, 0, 0), deg_to_rad(input_dir.y * TURN_SPEED) * delta)
		rotate_object_local(Vector3(0, 0, 1), deg_to_rad(input_dir.x * TURN_SPEED) * delta)
	
	move_and_slide()
	
	var last_slide_collision = get_last_slide_collision()
	if last_slide_collision and last_slide_collision.get_collider() is Asteroid and abs(velocity.length()) > CRASH_VELOCITY:
		velocity = last_slide_collision.get_normal() * REBOUND_SPEED
		Singleton.generate_damage()
		Singleton.audio_thing.crash.play()
	elif last_slide_collision and last_slide_collision.get_collider() is Asteroid:
		Singleton.audio_thing.bump.play()

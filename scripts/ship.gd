extends CharacterBody3D


const ACCEL = 5.0
const DECEL = 0.3
const MAX_SPEED = 500.0
const TURN_SPEED = 100.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Get the player camera
@onready var main_camera := $Marker/Camera
@onready var marker_3d = $Marker

# Make the camera variables
var camera_rotation = Vector2(0, 0)
var mouse_sensitivity := 0.003


func _ready() -> void:
	# Remove the mouse from the screen and just capture its movement
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event) -> void:
	# If escape is pressed reveal the mouse
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	# Accelerate
	if Input.is_action_pressed("thrust"):
		velocity -= basis.z * ACCEL * delta
	elif Input.is_action_pressed("brake"):
		velocity = velocity.move_toward(Vector3.ZERO, DECEL)
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	rotate_object_local(Vector3(1, 0, 0), deg_to_rad(input_dir.y * TURN_SPEED) * delta)
	rotate_object_local(Vector3(0, 0, 01), deg_to_rad(input_dir.x * TURN_SPEED) * delta)
	
	
	move_and_slide()
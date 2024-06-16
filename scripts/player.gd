class_name Player extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Get the player camera
@onready var main_camera := $Camera
@onready var progress_bar = $CanvasLayer/ProgressBar
@onready var screen_detector = $Camera/ScreenDetector
@onready var sound_cooldown = $SoundCooldown
@onready var repair = $Repair

# Make the camera variables
var camera_rotation := Vector2(0, 0)
var mouse_sensitivity := 0.002
var holding_repair := 0.0


func _ready() -> void:
	# Remove the mouse from the screen and just capture its movement
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event) -> void:
	# If escape is pressed reveal the mouse
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if not Singleton.shipping:
		# Get the mouse movement
		if event is InputEventMouseMotion:
			# Get how much the mouse has moved and pass it onto the camera_look function
			var relative_position = event.relative * mouse_sensitivity
			camera_look(relative_position)

# Rotate the camera
func camera_look(movement: Vector2) -> void:
	# Add how much the camera has moved to the camera rotation
	camera_rotation += movement
	# Stop the player from making the camera go upside down by looking too far up and down
	camera_rotation.y = clamp(camera_rotation.y, deg_to_rad(-90), deg_to_rad(90))
	
	# Reset the transform basis
	transform.basis = Basis()
	main_camera.transform.basis = Basis()
	
	# Finally rotate the object, the player and camera needs to rotate on the x and only the camera should rotate on the y
	rotate_object_local(Vector3.UP, -camera_rotation.x)
	main_camera.rotate_object_local(Vector3.RIGHT, -camera_rotation.y)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if not Singleton.shipping:
		var detected_collider = screen_detector.get_collider()
		if detected_collider is LookAtArea and Input.is_action_just_pressed("switch"):
			Singleton.switch_shipping()
		
		elif detected_collider is RepairThing and Input.is_action_pressed("switch") and Singleton.resources > 0:
			holding_repair += delta
			if sound_cooldown.is_stopped():
				repair.play()
				sound_cooldown.start()
			if holding_repair > progress_bar.max_value:
				detected_collider.repair()
		else:
			holding_repair = 0
		
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("left", "right", "forward", "backward")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()


func _process(_delta):
	if holding_repair:
		progress_bar.visible = true
		progress_bar.value = holding_repair
	else:
		progress_bar.visible = false

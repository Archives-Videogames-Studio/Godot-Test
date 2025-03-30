extends CharacterBody3D

@onready var camera_controller: Node3D = $Camera_Controller
@onready var attack_controller: Node3D = $Attack_Controller

@onready var animation_player: AnimationPlayer = $Visuals/Rogue/AnimationPlayer
@onready var visuals: Node3D = $Visuals


const JUMP_VELOCITY = 4.5

var BASE_SPEED = 2.0
var RUN_SPEED = BASE_SPEED * 2
var SPEED = BASE_SPEED


func _physics_process(delta: float) -> void:
	
	var jumping = false
	
	# Add the gravity.
	if not is_on_floor():
		animation_player.play("Jump_Idle")
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		animation_player.play("Jump_Start")
		velocity.y = JUMP_VELOCITY
		jumping = true
	
	if is_on_floor():
		if jumping:
			animation_player.play("Jump_Land")
			jumping = false
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var run := Input.is_action_pressed("run")
	
	if direction:
		
		if run:
			if animation_player.current_animation != "Running_A":
				animation_player.play("Running_A")
			SPEED = RUN_SPEED
			
		elif !run:
			if animation_player.current_animation != "Walkin_A":
				animation_player.play("Walking_A")
			SPEED = BASE_SPEED
			
		visuals.look_at(position + direction)
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		
		if animation_player.current_animation != "Idle":
			animation_player.play("Idle")
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
		
	


	move_and_slide()

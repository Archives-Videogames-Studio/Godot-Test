extends Node3D

@onready var camera_mount: Node3D = $"../Camera_mount"
@onready var player: CharacterBody3D = $".."

var min_vertical_angle = -90
var max_vertical_angle = 60 

@export var mouse_sens = 0.5
@export var joy_sens = 0.5


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		camera_mount.rotate_x(
			deg_to_rad(
				-event.relative.y * mouse_sens
				)
			)
		camera_mount.rotation_degrees.x = clamp(
			camera_mount.rotation_degrees.x, 
			min_vertical_angle, 
			max_vertical_angle
		)

func _process(delta):

	var joy_x = Input.get_action_strength("look_right") - Input.get_action_strength("loo_left")
	var joy_y = Input.get_action_strength("look_down") - Input.get_action_strength("look_up")

	if abs(joy_x) > 0.1:
		player.rotate_y(deg_to_rad(-joy_x * joy_sens))

	if abs(joy_y) > 0.1:
		camera_mount.rotate_x(deg_to_rad(-joy_y * joy_sens))
		camera_mount.rotation_degrees.x = clamp(
			camera_mount.rotation_degrees.x, 
			min_vertical_angle, 
			max_vertical_angle
		)

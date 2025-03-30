extends Node3D

@onready var main_camera: Camera3D = $"../Camera_mount/MainCamera"
@onready var aim_camera: Camera3D = $"../Camera_mount/AimCamera"
@onready var animation_player: AnimationPlayer = $"../Visuals/Rogue/AnimationPlayer"

var is_aiming := false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("aim") and !is_aiming:
		if animation_player.current_animation != "2H_Melee_Attack_Spinning":
			animation_player.play("2H_Melee_Attack_Spinning",-1, 1.0, false)
		aim_camera.current = true
		is_aiming = true
	elif Input.is_action_just_released("aim") and is_aiming:
		main_camera.current = true
		is_aiming = false

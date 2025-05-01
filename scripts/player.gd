extends CharacterBody3D
class_name Player


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


signal new_target(target: Vector3)


@onready var player_graphics: Node3D = $PlayerGraphics


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()


func _on_player_move_to(target_position: Vector3):
	new_target.emit(target_position)

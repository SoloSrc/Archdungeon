extends CharacterBody3D
class_name Player


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const INTERACT_DISTANCE = 1.5


signal new_target(target: Vector3)


@onready var player_graphics: Node3D = $PlayerGraphics
var interactable: Node3D


func _process(_delta: float) -> void:
	if not interactable:
		return
	var distance: float = (interactable.global_position - global_position).length()
	if distance <= INTERACT_DISTANCE:
		interact_with()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()


func _on_player_interact_with(collider: Node3D, target_position: Vector3):
	new_target.emit(target_position)
	var look_at_target = target_position
	look_at_target.y = global_transform.origin.y
	if look_at_target != global_transform.origin:
		look_at(look_at_target, Vector3.UP)
	interactable = collider


func interact_with() -> void:
	if interactable.owner is Doorway:
		var doorway: Doorway = interactable.owner as Doorway
		doorway.open()
		interactable = null

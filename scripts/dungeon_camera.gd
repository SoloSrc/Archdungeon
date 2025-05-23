extends Camera3D
class_name DungeonCamera


const RAY_LENGTH = 1000
const POINTER_C = preload("res://assets/kenney_cursor-pack/Vector/Outline/pointer_c.svg")
const STEPS = preload("res://assets/kenney_cursor-pack/Vector/Outline/steps.svg")
const HAND_OPEN = preload("res://assets/kenney_cursor-pack/Vector/Outline/hand_open.svg")
const DOOR = preload("res://assets/kenney_cursor-pack/Vector/Outline/door.svg")


signal player_interact_with(collider: Node3D, target_position: Vector3)


@export var target: Node3D
var offset: Vector3
var is_mouse_pressed: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(target != null, "The camera target cannot be null")
	look_at(target.global_position)
	offset = target.global_position - global_position
	is_mouse_pressed = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target_position = target.global_position - offset
	global_position.x = target_position.x
	global_position.z = target_position.z
	global_position.y = lerp(global_position.y, target_position.y, delta * 2)


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouse:
		return
	var mouse_event: InputEventMouse = event as InputEventMouse
	var collision = get_mouse_click_collision(mouse_event)
	if not collision or not collision["collider"]:
		return
	var collider: PhysicsBody3D = collision["collider"]
	if collider.is_in_group("Walkable"):
		Input.set_custom_mouse_cursor(STEPS)
	elif collider.is_in_group("Doorway"):
		Input.set_custom_mouse_cursor(DOOR)
	else:
		Input.set_custom_mouse_cursor(POINTER_C)
		return
	if mouse_event is InputEventMouseButton:
		var mouse_button_event: InputEventMouseButton = mouse_event as InputEventMouseButton
		if mouse_button_event.pressed:
			is_mouse_pressed = true
		else:
			is_mouse_pressed = false
	if not is_mouse_pressed:
		return
	var target_position: Vector3 = collision["position"]
	player_interact_with.emit(collider, target_position)


func get_mouse_click_collision(mouse_event: InputEventMouse) -> Dictionary:
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var start: Vector3 = project_ray_origin(mouse_event.position)
	var end: Vector3 = start + project_ray_normal(mouse_event.position) * RAY_LENGTH
	var params: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	params.from = start
	params.to = end
	params.collide_with_bodies = true
	params.collision_mask = 2
	return space_state.intersect_ray(params)

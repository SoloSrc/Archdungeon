extends Camera3D
class_name DungeonCamera


const RAY_LENGTH = 1000


signal player_move_to(target_position: Vector3)


@export var target: Node3D
var offset: Vector3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(target != null, "The camera target cannot be null")
	offset = target.global_position - global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	look_at(target.global_position)
	global_position = target.global_position - offset


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	var mouse_event: InputEventMouseButton = event as InputEventMouseButton
	if not mouse_event.pressed or not mouse_event.button_index == MOUSE_BUTTON_LEFT:
		return
	var collision = get_mouse_click_collision(mouse_event)
	if not collision or not collision["collider"]:
		return
	var collider: PhysicsBody3D = collision["collider"]
	if not collider.is_in_group("Walkable"):
		return
	var target_position: Vector3 = collision["position"]
	player_move_to.emit(target_position)


func get_mouse_click_collision(mouse_event: InputEventMouseButton) -> Dictionary:
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var start: Vector3 = project_ray_origin(mouse_event.position)
	var end: Vector3 = start + project_ray_normal(mouse_event.position) * RAY_LENGTH
	var params: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	params.from = start
	params.to = end
	params.collide_with_bodies = true
	params.collision_mask = 2
	return space_state.intersect_ray(params)

extends PlayerState
class_name PlayerIdleState


var is_on_this_state: bool = false


func _ready() -> void:
	await super._ready()
	player.new_target.connect(_on_player_new_target)


func enter(previous_state_path: String) -> void:
	player_graphics.play("Idle")
	is_on_this_state = true


func exit() -> void:
	pass


func update(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * player.SPEED
		player.velocity.z = direction.z * player.SPEED
		finished.emit("Moving")
		is_on_this_state = false


func _on_player_new_target(_target: Vector3) -> void:
	if not is_on_this_state:
		return
	finished.emit("Moving")
	is_on_this_state = false

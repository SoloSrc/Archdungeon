extends PlayerState
class_name PlayerMovingState


var curr_target: Vector3 = Vector3.ZERO
var has_target: bool = false


func _ready() -> void:
	await super._ready()
	player.new_target.connect(_on_player_new_target)


func enter(previous_state_path: String) -> void:
	player_graphics.play("Running_B")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if not direction and has_target:
		var distance = curr_target - player.global_position
		if distance.length() < 0.25:
			has_target = false
		distance.y = 0
		direction = distance.normalized()
	if direction:
		player.velocity.x = direction.x * player.SPEED
		player.velocity.z = direction.z * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, player.SPEED)
	var curr_velocity = player.velocity
	if player.velocity.x == 0.0 and player.velocity.z == 0.0:
		finished.emit("Idle")


func _on_player_new_target(target: Vector3) -> void:
	curr_target = target
	has_target = true

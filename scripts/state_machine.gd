extends Node
class_name StateMachine


var curr_state: State


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			child.finished.connect(_transition_to_next_state)
	await owner.ready
	curr_state = get_child(0)
	curr_state.enter("")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	curr_state.update(delta)


func _transition_to_next_state(target_state_path: String) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Has no node with path: " + target_state_path)
	var previous_state_path = curr_state.name
	curr_state.exit()
	curr_state = get_node(target_state_path)
	curr_state.enter(previous_state_path)

extends Node
class_name State


signal finished(next_state_path: String)


func enter(previous_state_path: String) -> void:
	pass


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass

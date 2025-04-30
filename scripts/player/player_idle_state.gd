extends PlayerState
class_name PlayerIdleState


func enter(previous_state_path: String) -> void:
	player_graphics.play("Idle")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass

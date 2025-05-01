extends Node
class_name Level


func _on_wall_doorway_opened(room: Room) -> void:
	room.process_mode = Node.PROCESS_MODE_INHERIT
	room.visible = true

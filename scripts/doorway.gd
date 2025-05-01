extends Node3D
class_name Doorway


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func open() -> void:
	animation_player.play("open_door")

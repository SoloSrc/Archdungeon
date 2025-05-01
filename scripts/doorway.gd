extends Node3D
class_name Doorway


signal opened(room: Room)


@export var room: Room
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func open() -> void:
	animation_player.play("open_door")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	opened.emit(room)

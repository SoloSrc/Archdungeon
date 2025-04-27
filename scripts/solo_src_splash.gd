extends Control


const BUSY_HOURGLASS_OUTLINE_DETAIL = preload("res://assets/kenney_cursor-pack/Vector/Outline/busy_hourglass_outline_detail.svg")
const POINTER_C = preload("res://assets/kenney_cursor-pack/Vector/Outline/pointer_c.svg")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(BUSY_HOURGLASS_OUTLINE_DETAIL)


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
	Input.set_custom_mouse_cursor(POINTER_C)

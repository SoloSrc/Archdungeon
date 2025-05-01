extends Control


const BUSY_HOURGLASS_OUTLINE_DETAIL = preload("res://assets/kenney_cursor-pack/Vector/Outline/busy_hourglass_outline_detail.svg")
const POINTER_C = preload("res://assets/kenney_cursor-pack/Vector/Outline/pointer_c.svg")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_tutorial_pressed() -> void:
	Input.set_custom_mouse_cursor(BUSY_HOURGLASS_OUTLINE_DETAIL)
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
	Input.set_custom_mouse_cursor(POINTER_C)

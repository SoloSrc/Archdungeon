extends Camera3D
class_name DungeonCamera


@export var target: Node3D
var offset: Vector3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(target != null, "The camera target cannot be null")
	offset = target.global_position - global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	look_at(target.global_position)
	global_position = target.global_position - offset

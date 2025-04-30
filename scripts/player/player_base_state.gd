extends State
class_name PlayerState


const IDLE = "Idle"


var player: CharacterBody3D
var player_graphics: AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	player = owner as CharacterBody3D
	assert(player != null, "The PlayerState type must be used on the Player Scene")
	player_graphics = player.get_node("PlayerGraphics/AnimationPlayer")
	assert(player_graphics != null, "The PlayerState type must have a sibling AnimationPlayer")

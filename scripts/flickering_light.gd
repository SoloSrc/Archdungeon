extends OmniLight3D
class_name FlickeringLight

@export var noise: NoiseTexture2D
@export var minimum_energy: float = 0.5

var time_passed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_passed = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	var sampled_noise = abs(noise.noise.get_noise_1d(time_passed))
	sampled_noise = clamp(sampled_noise, 0, 0.25) * 2
	light_energy = minimum_energy + sampled_noise

extends Camera2D
class_name CameraEvent

signal camera_shake(intensity : float)

@export var randomStrenght: float = 10.0
@export var shakeFade: float = 15.0

const LEFT_SCREEN = 640*2
const RIGHT_SCREEN = 0

var rng = RandomNumberGenerator.new()
var shake_strenght: float = 0.0

@onready var turn_manager = get_tree().get_first_node_in_group("TurnManagerBattle")

func _ready() -> void:
	turn_manager.turn_changed.connect(_on_turn_changed)

func apply_shake():
	shake_strenght = randomStrenght

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_end") && OS.is_debug_build():
		position.x = LEFT_SCREEN if (position.x == RIGHT_SCREEN) else RIGHT_SCREEN
	
	if shake_strenght > 0:
		shake_strenght = lerpf(shake_strenght, 0, shakeFade * delta)
		offset = randomOffset()
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strenght, shake_strenght), rng.randf_range(-shake_strenght, shake_strenght))

func _on_turn_changed(turn_who, number):
	if turn_who == 0:
		position.x = RIGHT_SCREEN
	else:
		position.x = LEFT_SCREEN

extends Entity
class_name Player

@export_group("advanced")
@export var offset : Vector2 = Vector2.ZERO
@export var curve : Curve

var can_shoot : bool = true
var can_move : bool = true
var direction : Vector2
var invulnerabilty : bool = false
var death = false

@onready var particle: GPUParticles2D = $Particle
@onready var sprite: Sprite2D = $Sprite
@onready var invalid_label: Label = $InvalidLabel
@onready var turn_manager = get_tree().get_first_node_in_group("TurnManagerBattle")

func _on_entity_ready() -> void:
	GameEvents.emit_loading_started()

	sprite.texture = stats.attribute.sprite
	particle.texture = stats.attribute.sprite
	turn_manager.turn_changed.connect(_on_turn_changed)

	GameEvents.player_ready.emit()
	GameEvents.emit_loading_finished()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.is_action_pressed("restart") and OS.is_debug_build():
			get_tree().reload_current_scene()
		
		elif event.is_action_pressed("wheel_up"):
			weapon.switch_weapon(1)
		elif event.is_action_pressed("wheel_down"):
			weapon.switch_weapon(-1)
		
		elif event.is_action_pressed("right_click") and OS.is_debug_build():
			stamina.stamina_change.emit(45)

	if event.is_action_pressed("shoot") and can_move and stamina.current_stamina > 0:
		weapon.weapon.shoot()

func _physics_process(_delta: float) -> void:
	if !death:
		$HurtboxPlayer/Col.disabled = invulnerabilty or death
		sprite.self_modulate = Color(1, 1, 1, 0.435) if invulnerabilty else Color(1, 1, 1, 1)

		particle.emitting = (direction != Vector2.ZERO and velocity != Vector2.ZERO)

		direction = Vector2(
			Input.get_axis("left", "right"),
			Input.get_axis("up", "down")
		).normalized()

		invalid_label.visible = true if ((direction or Input.is_action_pressed("shoot")) and !can_move) else false

		if direction and can_move:
			stamina.stamina_drop.emit(1)
			velocity = direction * stats.attribute.speed_max
		else:
			velocity = velocity.move_toward(Vector2.ZERO, stats.attribute.speed_max)

		move_and_slide()
		
func die():
	var death_animation = stats.attribute.death_animation.instantiate()
	
	death_animation.position = global_position
	
	get_parent().call_deferred("add_child", death_animation)
	$HurtboxPlayer/Col.call_deferred("set_disabled", true)
	
	death = true
	visible = false

func _on_turn_changed(turn_who):
	set_physics_process(turn_who == 0)
	set_process_input(turn_who == 0)

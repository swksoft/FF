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

func _on_entity_ready() -> void:
	GameEvents.emit_loading_started()

	sprite.texture = stats.attribute.sprite
	particle.texture = stats.attribute.sprite

	GameEvents.player_ready.emit()
	GameEvents.emit_loading_finished()
	
	super._on_entity_ready()
	
	_on_turn_changed(turn_manager.turn_who, turn_manager.current_turn)

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
		
		elif event.is_action_pressed("finish_turn"):
			finish_turn.emit()

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

		invalid_label.visible = true if ((direction or Input.is_action_pressed("shoot")) and stamina.current_stamina <= 0) else false

		if direction and can_move and stamina.current_stamina > 0:
			stamina.stamina_drop.emit(1)
			velocity = direction * stats.attribute.speed_max
		else:
			velocity = velocity.move_toward(Vector2.ZERO, stats.attribute.speed_max)

		move_and_slide()
		
func die():
	$HurtboxPlayer/Col.call_deferred("set_disabled", true)
	death = true
	visible = false
	
	turn_manager.update_entity_count("player", -1)
	super.die()

func _on_turn_changed(_turn_who, _number):
	stamina.stamina_change.emit(50)
	set_physics_process(_turn_who == 0)
	set_process_input(_turn_who == 0)

func _on_turn_manager_battle_battle_ended(_winner: String) -> void:
	set_physics_process(false)

func _on_finish_turn() -> void:
	print("TURNO FINALIZADO")

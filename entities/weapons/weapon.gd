extends Node2D
class_name Weapon

const BULLET_SCENE = preload("res://entities/weapons/bullet.tscn")

@export var weapon_stat : WeaponResource

var collision_layer : int
var can_shoot := true
var direction : Vector2

@onready var cooldown: Timer = $Cooldown

#func _ready() -> void:
	#if weapon_stat == null:
		#push_error("NO SE ENCONTRO WEAPON STAT")
		#return

func play_sound():
	var sfx = AudioStreamPlayer.new()
		
	add_child(sfx)
	sfx.stream = weapon_stat.shoot_sfx
	sfx.finished.connect(Callable(self, "_on_sfx_finished").bind(sfx))
	sfx.bus = "SFX"
	sfx.play()

func shoot():
	if can_shoot:
		can_shoot = false
		
		cooldown.wait_time = weapon_stat.cooldown_shoot
		cooldown.start()
	
		get_parent().get_parent().stamina.current_stamina -= weapon_stat.stamina_consumption
		
		if weapon_stat.bullet_data == null:
			push_error("Bullet stats no se han cargado correctamente")
			return
		
		var bullet : Bullet = BULLET_SCENE.instantiate()

		if weapon_stat.bullet_data != null:
			bullet.stats = weapon_stat.bullet_data
		else:
			push_warning("Bullet.stats es nulo; se asignará un nuevo recurso dinámicamente.")
			bullet.stats = BulletResource.new()

		bullet.direction = direction
		bullet.position = get_parent().get_parent().global_position
		bullet.set_collision_layer_value(collision_layer, true)
		
		get_tree().get_root().add_child(bullet)
		
		play_sound()

func _on_sfx_finished(sfx: AudioStreamPlayer) -> void:
	if sfx != null:
		sfx.queue_free()

func _on_cooldown_timeout() -> void:
	can_shoot = true

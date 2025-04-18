extends HitboxComponent
class_name Bullet

@export var trail_lenght = 5
@export var stats : BulletResource

var pierce : int = 0
var direction : Vector2 = Vector2.ZERO

@onready var sprite: Sprite2D = $Sprite
@onready var despawn_timer: Timer = $DespawnTimer

func _ready():
	if stats == null:
		push_error("Stats no cargadas")
		return
	if stats.sprite_bullet != null:
		sprite.texture = stats.sprite_bullet
	else:
		push_error("El recurso sprite_bullet es nulo")
	
func _process(delta):
	sprite.flip_v = true if (direction.x < 0 ) else false
	_trajectory(delta)
	
func _trajectory(delta):
	position += direction * stats.speed * delta

func _on_despawn_timeout():
	queue_free()

func on_hit(area):
	DamageNumbers.display_number(stats.damage, area.global_position + Vector2(0, -18))
	queue_free()

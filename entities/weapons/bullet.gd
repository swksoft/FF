extends HitboxComponent
class_name Bullet

@export var trail_lenght = 5

var stats : BulletResource
var pierce : int = 0
var direction : Vector2 = Vector2.ZERO

func _ready():
	if stats == null:
		push_error("Stats no cargadas")
		return
	
	name = stats.name_bullet
	$DespawnTimer.wait_time = stats.lifetime
	$DespawnTimer.start()
	$Sprite.texture = stats.sprite_bullet
	
func _process(delta):
	$Sprite.flip_v = true if (direction.x < 0 ) else false
	trajectory(delta)
	
func trajectory(delta):
	position += direction * stats.speed * delta

func _on_despawn_timeout():
	queue_free()

func on_hit(area):
	DamageNumbers.display_number(stats.damage, global_position + Vector2(0, -18))
	queue_free()

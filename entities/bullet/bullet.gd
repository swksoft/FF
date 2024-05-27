extends Area2D
class_name Bullet

@export var time_despawn : float = 2.0
@export var speed : int = 500
@export var trail_lenght = 5

@onready var despawn = $Despawn
@onready var trails = $Trails

func _ready():
	trails.MAX_LENGHT = trail_lenght
	despawn.wait_time = time_despawn

func _process(delta):
	position += Vector2.RIGHT * speed * delta

func _on_despawn_timeout():
	queue_free()

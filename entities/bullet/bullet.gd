extends Area2D
class_name Bullet

@export var time_despawn : float = 2.0
@export var speed : int = 500
@export var trail_lenght = 5
@export var damage = 1
@export var max_pierce = 3

var pierce : int = 0
var direction : Vector2 = Vector2.RIGHT

@onready var despawn = $Despawn
@onready var trails = $Trails

func _ready():
	despawn.wait_time = time_despawn

func _process(delta):
	position += direction * speed * delta

func _on_despawn_timeout():
	queue_free()

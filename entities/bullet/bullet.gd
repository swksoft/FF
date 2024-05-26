extends Area2D

@export var time_despawn : float = 2.0
@export var speed : int = 500

@onready var despawn = $Despawn

func _ready():
	despawn.wait_time = time_despawn
	

func _process(delta):
	position += Vector2.RIGHT * speed * delta

func _on_despawn_timeout():
	queue_free()

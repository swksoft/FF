extends State
class_name EnemySpawn

@export var boss : CharacterBody2D
@export var spawn_scene : PackedScene

func Physics_Update(delta: float):
	var spawn = spawn_scene.instantiate()
	spawn.position = boss.global_position
	spawn.can_shoot = false
	add_child(spawn)
	Transitioned.emit(self, "movepong")

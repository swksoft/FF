extends State
class_name EnemyIdle

@export var time : float = 5

func randomize_time():
	time = randf_range(3,8)

func Enter():
	randomize_time()

func Update(delta: float):
	if time > 0:
		time -= delta
	else:
		Transitioned.emit(self, "spawn")


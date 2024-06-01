extends State
class_name EnemyPong

@export var boss : CharacterBody2D
@export var speed := 300.0

@export var direction := Vector2(0, 1).normalized()
var screen_size := Vector2(640, 360)
var move_time : float

func randomize_time():
	direction.y = randi_range(-1,1)
	move_time = randf_range(3,6)

func Enter():
	randomize_time()

func Update(delta: float):
	if move_time > 0:
		move_time -= delta
	else:
		Transitioned.emit(self, "shootplayer")
	
	if direction.y == 0:
		Transitioned.emit(self, "spawn")
	
	if boss:
		if boss.position.x <= 0 or boss.position.x >= screen_size.x:
			direction.x *= -1 # Invertir dirección en el eje X

		if boss.position.y <= 0 or boss.position.y >= screen_size.y:
			direction.y *= -1 # Invertir dirección en el eje Y

		boss.position.x = clamp(boss.position.x, 0, screen_size.x)
		boss.position.y = clamp(boss.position.y, 0, screen_size.y)

func Physics_Update(delta: float):
	if boss:
		boss.position += direction * speed * delta
		


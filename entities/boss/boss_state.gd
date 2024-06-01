extends Enemy
#class_name Boss

@export var max_hp : int = 100
@export var enemy_spawn_scene : PackedScene

const SCREEN_TOP: float = 0
const SCREEN_BOTTOM: float = 360  # Altura de la pantalla

enum states {SHOOT, MOVE, CREATE_ENEMIES}

var hp : int
var current_state = states.CREATE_ENEMIES

var instance = 8

func _ready():
	hp = max_hp

func _process(delta):
	match current_state:
		"SHOOT":
			shoot_state()
		"MOVE":
			move_state(delta)
		"CREATE_ENEMIES":
			create_enemies_state()

func get_damage():
	hp -= 1
	if hp <= 0:
		death()

func shoot_state():
	var player = get_tree().get_first_node_in_group("Player")
	
	for i in instance:
		var bullet = bullet_scene.instantiate()
		
		bullet.position = global_position
		bullet.set_collision_layer_value(2, true)
		bullet.scale *= 2
		bullet.direction = (player.global_position - global_position).normalized()
		bullet.max_pierce = 2
		
		get_parent().add_child(bullet)

func move_state(delta):
	direction = Vector2.UP
	
	var velocity = direction * speed * delta
	
	move_and_slide()
	
	var current_position = global_position
	
	if current_position.y <= SCREEN_TOP:
		direction = Vector2(0, 1)
	elif current_position.y >= SCREEN_BOTTOM:
		direction = Vector2(0, -1)

func create_enemies_state():
	var enemy_spawn = enemy_spawn_scene.instantiate()
	
	enemy_spawn.position = global_position
	get_parent().add_child(enemy_spawn)
	
func _on_state_manager_transitioned():
	var states_selected = states.keys()[randi() % states.size()]
	
	current_state = states_selected

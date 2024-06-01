extends Enemy

var player = null

var player_position = null

func _physics_process(delta):
	player = get_tree().get_first_node_in_group("Player")
	
	var direction = (player.position - position).normalized()
	position += direction * speed * delta
	move_and_slide()
	



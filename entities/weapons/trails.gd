extends Line2D
class_name Trails

var queue : Array
@export var MAX_LENGHT : int

func _get_position():
	return get_parent().position

func _process(_delta):
	var pos = _get_position()
	add_point(pos)
	
	queue.push_front(_get_position())
	
	if queue.size() > MAX_LENGHT:
		queue.pop_back()
		
	clear_points()
	
	for point in queue:
		add_point(point)
		

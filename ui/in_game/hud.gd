extends CanvasLayer

@onready var loading_screen: ColorRect = $Hud/LoadingScreen

@export var entities: Array[Node]

var nodes_loading := 0

func _ready() -> void:
	GameEvents.loading_started.connect(_on_node_loading_started)
	GameEvents.loading_finished.connect(_on_node_loading_finished)

func _on_node_loading_started() -> void:
	nodes_loading += 1

	loading_screen.visible = true
	
	print_debug(nodes_loading)

func _on_node_loading_finished() -> void:
	nodes_loading -= 1
	
	if nodes_loading <= 0:
		loading_screen.visible = false

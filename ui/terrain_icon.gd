extends VBoxContainer

@export var name_icon : String = "None"
@export var max_lives : int = 3
@export var is_conquered : bool = false
@export_enum("gomez", "miau", "alumina", "cagliostro", "bob") var character : int

var heart_scene : PackedScene = load("res://ui/heart.tscn")
var hollow_heart_scene : PackedScene = load("res://ui/hollow_heart.tscn")
var heart_good : PackedScene = load("res://ui/heart_good.tscn")
var icons : Array = [preload("res://assets/sprites/iconsga3.png"), preload("res://assets/sprites/iconsga1.png"), preload("res://assets/sprites/iconsga4.png"), preload("res://assets/sprites/iconsga2.png"), preload("res://assets/sprites/iconsga5.png"), preload("res://assets/sprites/iconsga6.png")]

var current_lives : int

@onready var label = $Label
@onready var texture_button = $TextureButton

func _ready():
	current_lives = max_lives
	label.text = str(name_icon)
	
	check_terrain_state()

func _process(delta):
	if Input.is_action_just_pressed("left"):
		pass
	elif Input.is_action_just_pressed("right"):
		pass

func check_terrain_state():
	if is_conquered == false:
		match character:
			0:
				texture_button.texture_normal = icons[character]
			1:
				texture_button.texture_normal = icons[character]
			2:
				texture_button.texture_normal = icons[character]
			3:
				texture_button.texture_normal = icons[character]
			4:
				texture_button.texture_normal = icons[character]
	else:
		texture_button.texture_normal = icons[5]
	
	for i in current_lives:
		var heart = heart_scene.instantiate()
		if is_conquered == true:
			heart = heart_good.instantiate()
			
		get_node("Lives").add_child(heart)
	
func _on_successful_conquest():
	current_lives -= 1
	check_terrain_state()

func _on_successful_defense():
	current_lives -= 0
	check_terrain_state()
	
func _on_failed_defense():
	current_lives += 1
	
func _on_failed_conquest():
	current_lives += 0

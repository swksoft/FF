extends Resource
class_name BulletResource

@export var name_bullet : String = "No Name"
@export var sprite_bullet : CompressedTexture2D = load("res://assets/sprites/iconsga5.png")
@export_category("gameplay_stats")
@export var damage : float = 10
@export var speed : float = 50
@export var lifetime : float = 5
@export var explosion_radius : float = 0
@export var pierce : int = 0

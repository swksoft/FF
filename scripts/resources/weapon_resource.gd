extends Resource
class_name WeaponResource

@export var weapon_name : String
@export var manufacturer : String
@export var icon : CompressedTexture2D 
@export_multiline var description : String
@export var bullet_data : Array[BulletResource] = []
@export_group("audio")
@export var shoot_sfx : AudioStream = load("res://assets/sfx/projectile1.wav")
@export var hit_sfx : AudioStream = load("res://assets/sfx/projectile1.wav")
@export_category("gameplay_stats")
@export var price_solaris : float
@export var total_uses : int
@export var cooldown_shoot : float
@export var stamina_consumption : float

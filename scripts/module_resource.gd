@tool

extends Resource

class_name ModuleResource

@export var damage: int: set = set_damage
@export var texture: Texture2D: set = set_texture
@export var ammo: int: set = set_ammo
@export var has_infinity_ammo: bool: set = set_has_infinity_ammo
@export var bullet_path: String: set = set_bullet_path

func set_damage(_damage: int):
	damage = _damage
	
func set_texture(_texture: Texture2D):
	texture = _texture
	
func set_ammo(_ammo: int):
	ammo = _ammo
	
func set_has_infinity_ammo(_has_infinity_ammo: bool):
	has_infinity_ammo = _has_infinity_ammo
	
func set_bullet_path(_bullet_path: String):
	bullet_path = _bullet_path

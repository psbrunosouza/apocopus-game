@tool

extends Resource

class_name ModuleResource

@export var damage: int: set = set_damage
@export var max_ammo: int: set = set_ammo
@export var has_infinity_ammo: bool: set = set_has_infinity_ammo
@export var bullet_path: String: set = set_bullet_path
@export var shatter_effect_path: String
@export var facing_foward: Texture2D
@export var facing_down: Texture2D
@export var facing_up: Texture2D

func set_damage(_damage: int):
	damage = _damage
	
func set_ammo(_max_ammo: int):
	max_ammo = _max_ammo
	
func set_has_infinity_ammo(_has_infinity_ammo: bool):
	has_infinity_ammo = _has_infinity_ammo
	
func set_bullet_path(_bullet_path: String):
	bullet_path = _bullet_path

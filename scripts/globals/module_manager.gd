extends Node

signal shot_fired(remaining_ammo: int, resource: ModuleResource)

var module: ModuleResource:
	set = set_module
var current_ammo: int = 0

func set_module(_module):
	module = _module
	current_ammo = module.max_ammo

extends TextureRect

@export var ammo_label: Label

var ammo: int = 0

var module_resource: ModuleResource:
	set = set_module_resource 

func _ready() -> void:
	ModuleManager.shot_fired.connect(_on_module_shot_fired)
	
func set_module_resource(_module_resource: ModuleResource):
	module_resource = _module_resource
	texture = module_resource.icon

func _on_module_shot_fired(remaining_ammo: int, resource: ModuleResource) -> void:
	ammo = remaining_ammo
	if resource.has_infinity_ammo:
		ammo_label.text = "∞"
	else:
		ammo_label.text = str(ammo)
	

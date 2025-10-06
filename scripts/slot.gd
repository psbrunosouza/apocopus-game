@tool

extends Button

class_name  Slot

@export var equipment_resource: EquipResource: set = _set_equip_resource
@export var texture_rect: TextureRect 

func _set_equip_resource(resource): 
	equipment_resource = resource
	texture_rect.texture = equipment_resource.texture

@tool

extends Button

class_name Equipment

@export var equipment_resource: EquipResource: set = _set_equipment_resource
@export var texture: TextureRect = TextureRect.new()

func _set_equipment_resource(resource):
	equipment_resource = resource
	texture.texture = equipment_resource.texture

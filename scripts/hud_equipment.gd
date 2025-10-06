@tool

class_name HudEquipment

extends Button

@export var image: TextureRect
@export var resource: EquipResource: set = _set_resource

func _set_resource(_resource: EquipResource):
	resource = _resource
	image.texture = _resource.texture

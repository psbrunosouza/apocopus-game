extends Resource

class_name EquipResource

enum Type {
	PISTOL,
	SUB,
	KNIFE
}

@export var texture: Texture2D
@export var name: String
@export var hint: String
@export var damage: int
@export var type: Type
@export var effects: Array = []

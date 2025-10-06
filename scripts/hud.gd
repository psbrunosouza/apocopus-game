extends Panel

@export var equipment_container: HBoxContainer 

func _ready() -> void:
	EquipManager.equipment_list_changed.connect(Callable(self, "get_equipment_list"))

func get_equipment_list(slots: Array[Slot]):
	if equipment_container.get_child_count() >= 1:
		for equipment_i in range(equipment_container.get_children().size()):
			var eq = equipment_container.get_children()[equipment_i] as HudEquipment
			eq.resource = slots[equipment_i].equipment_resource

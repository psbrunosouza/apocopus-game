extends CanvasLayer

@export var equipment_container: HBoxContainer 
var equipment_scene = preload("res://scenes/hud_equipment.tscn")

func _ready() -> void:
	EquipManager.equipment_list_changed.connect(Callable(self, "get_equipment_list"))

func get_equipment_list(slots: Array[Slot]):
	if equipment_container.get_child_count() >= 1:
		for equipment in equipment_container.get_children():
			equipment.queue_free()
		
	for slot in slots:
		var equipment: HudEquipment = equipment_scene.instantiate()
		equipment.resource = slot.equipment_resource
		equipment_container.add_child(equipment)

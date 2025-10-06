extends Panel
@export var selected_slot: Slot
@export var equipment_grid: GridContainer
var is_selecting: bool = false

func _ready() -> void:
	_generate_equipments()
	_set_focus_by_group(Group.EQUIPMENTS, Control.FOCUS_NONE)
	_set_focus_by_group(Group.SLOTS, Control.FOCUS_ALL)
	_emit_equipment_changes()

func _emit_equipment_changes():
	var slots: Array[Slot] = []
	for slot in get_tree().get_nodes_in_group(Group.SLOTS):
		slots.append(slot)
	EquipManager.equipment_list_changed.emit(slots)

func _generate_equipments():
	for equipment_index in range(EquipManager.equipment_resources.size()):
		var equip_scene = load("res://scenes/equipment.tscn") as PackedScene
		var equipment_instance = equip_scene.instantiate() as Equipment
		equipment_instance.equipment_resource = EquipManager.equipment_resources[equipment_index]
		EquipManager.equipments.append(equipment_instance)
		equipment_instance.add_to_group(Group.EQUIPMENTS)
		equipment_grid.add_child(equipment_instance)

func _set_focus_by_elements(equipment: Equipment, mode: FocusMode):
	for slot in get_tree().get_nodes_in_group(Group.SLOTS):
		var s = slot as Slot
		if s.equipment_resource and s.equipment_resource.name == equipment.equipment_resource.name:
			equipment.focus_mode = Control.FOCUS_NONE
			return
	equipment.focus_mode = mode

func _set_focus_by_group(group: String, mode: FocusMode):
	for node in get_tree().get_nodes_in_group(group):
		node.focus_mode = mode

func _physics_process(_delta: float) -> void:
	if GameManager.is_paused:
		if Input.is_action_just_pressed(Pad.A) and !is_selecting:
			var slot = get_viewport().gui_get_focus_owner() as Slot
			if !slot:
				return 
			
			selected_slot = slot
			
			_set_focus_by_group(Group.SLOTS, Control.FOCUS_NONE)
			for equipment in EquipManager.equipments:
				_set_focus_by_elements(equipment, Control.FOCUS_ALL)
			
			for equipment in EquipManager.equipments:
				if equipment.focus_mode == Control.FOCUS_ALL:
					equipment.grab_focus()
					break
			
			is_selecting = true
		
		elif Input.is_action_just_pressed(Pad.A) and is_selecting:
			var equipment = get_viewport().gui_get_focus_owner() as Equipment
			if equipment and equipment.focus_mode == Control.FOCUS_ALL:
				selected_slot.equipment_resource = equipment.equipment_resource
				
				_set_focus_by_group(Group.SLOTS, Control.FOCUS_ALL)
				_set_focus_by_group(Group.EQUIPMENTS, Control.FOCUS_NONE)
				
				selected_slot.grab_focus()
				_emit_equipment_changes()
			
			is_selecting = false
		
		if Input.is_action_just_pressed(Pad.START):
			if selected_slot:
				selected_slot.grab_focus()

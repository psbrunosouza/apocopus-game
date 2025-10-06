extends Node

signal equipment_list_changed(slots: Array[Slot])

var slot_selected: Slot = null
var equipments: Array[Equipment] = []
var equipment_resources: Array[EquipResource] = [
	preload("res://resources/pistol.tres"),
	preload("res://resources/sub.tres"),
	preload("res://resources/knife.tres"),
]

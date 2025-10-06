extends Node2D

class_name Module

@export var resource: ModuleResource
@export var player: Player
@export var ammo: int
@onready var bullets_container = get_tree().current_scene.get_node("Bullets")

var fire_rate_timer: float = 0.0

func _ready() -> void:
	ammo = resource.ammo

func _process(delta: float) -> void:
	_handle_shoot(delta)
	
func _handle_shoot(delta):
	if fire_rate_timer > 0:
		fire_rate_timer -= delta
	else: 
		fire_rate_timer = 0
	
	if (ammo > 0 or resource.has_infinity_ammo) and Input.is_action_just_pressed(Pad.X):
		var bullet_scene = load(resource.bullet_path) as PackedScene
		var bullet = bullet_scene.instantiate() as Bullet
		bullet.global_position = player.global_position
		bullet.facing_of = player.facing_of
		
		if fire_rate_timer == 0:
			fire_rate_timer = bullet.fire_rate
			bullets_container.add_child(bullet)
			
		ammo -= 1

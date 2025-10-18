extends Sprite2D

class_name Module

@onready var bullets_container = get_tree().get_first_node_in_group("bullets_container")

@export var resource: ModuleResource
@export var player: Player
@export var bullet_origin_left: Node2D
@export var bullet_origin_right: Node2D
@export var bullet_origin_up: Node2D
@export var bullet_origin_down: Node2D
@export var muzzle_flash_scene: PackedScene

var ammo: int

var fire_rate_timer: float = 0.0

func _ready() -> void:
	ammo = resource.max_ammo
	ModuleManager.shot_fired.emit(ammo, resource)

func _process(delta: float) -> void:
	_get_facing_direction()
	_handle_shoot(delta)
	
func _get_facing_direction():
	
	match player.facing:
		Vector2.UP:
			texture = resource.facing_up
		Vector2.DOWN:
			texture = resource.facing_down
		_:
			texture = resource.facing_foward
		
	if player.direction < 0:
		flip_h = true
	elif player.direction > 0:
		flip_h = false
	
func _handle_shoot(delta):
	if fire_rate_timer > 0:
		fire_rate_timer -= delta
	else: 
		fire_rate_timer = 0
	
	if (ammo > 0 or resource.has_infinity_ammo) and Input.is_action_just_pressed(Pad.X):
		var bullet_scene = load(resource.bullet_path) as PackedScene
		var bullet = bullet_scene.instantiate() as Bullet
		var muzzle_flash = muzzle_flash_scene.instantiate()
		
		bullet.facing = player.facing
		muzzle_flash.facing = player.facing
		bullet.equipment_resource = resource
		
		match player.facing:
			Vector2.RIGHT:
				bullet.global_position = bullet_origin_right.global_position
				muzzle_flash.position = bullet_origin_right.position
			Vector2.LEFT:
				bullet.global_position = bullet_origin_left.global_position
				muzzle_flash.position = bullet_origin_left.position
			Vector2.UP:
				bullet.global_position = bullet_origin_up.global_position
				muzzle_flash.position = bullet_origin_up.position
			Vector2.DOWN:
				bullet.global_position = bullet_origin_down.global_position
				muzzle_flash.position = bullet_origin_down.position
		
		if fire_rate_timer == 0:
			fire_rate_timer = bullet.fire_rate
			add_child(muzzle_flash)
			bullets_container.add_child(bullet)
			ammo -= 1
			
			ModuleManager.current_ammo = ammo
			ModuleManager.shot_fired.emit(ammo, resource)

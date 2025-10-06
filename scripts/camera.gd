extends Camera2D

@export var player: Node2D
@export var smoothing_speed: float = 5.0

# zones de deadzone horizontal (0-1)
@export var left_deadzone: float = 0.3
@export var right_deadzone: float = 0.7

# limites do mapa (devem ser definidos pelo mapa)
@export var map_left: float
@export var map_right: float
@export var map_top: float
@export var map_bottom: float

func _ready() -> void:
	make_current()

func _process(delta: float) -> void:
	if not player:
		return

	var vp_size = get_viewport_rect().size
	var half_vp = vp_size / 2
	var target = global_position

	# Horizontal
	var left_zone = map_left + vp_size.x * left_deadzone
	var right_zone = map_right - vp_size.x * (1.0 - right_deadzone)

	if player.global_position.x < left_zone:
		target.x = clamp(player.global_position.x, map_left + half_vp.x, map_right - half_vp.x)
	elif player.global_position.x > right_zone:
		target.x = clamp(player.global_position.x, map_left + half_vp.x, map_right - half_vp.x)
	else:
		# player está na zona central, câmera segue suavemente
		target.x = clamp(player.global_position.x, map_left + half_vp.x, map_right - half_vp.x)

	# Vertical
	target.y = clamp(player.global_position.y, map_top + half_vp.y, map_bottom - half_vp.y)

	# Smooth
	global_position = global_position.move_toward(target, smoothing_speed * delta)

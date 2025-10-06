extends CharacterBody2D
class_name Player

@export var module: Module 
@export var speed: float = 120.0
@export var gravity: float = 980.0
@export var friction: float = 0.75
@export var jump_force: float = -280.0
@export var double_jump_force: float = -300.0
@export var wall_jump_force: float = -280.0
@export var wall_jump_push: float = 150.0
@export var coyote_time: float = 0.1
@export var dash_force: float = 400.0
@export var wall_jump_timer: float = 0.0  
@export var player_direction: float = 1.0
@export var wall_ray_cast_left: RayCast2D
@export var wall_ray_cast_right: RayCast2D
@export var sprite: Sprite2D
@export var initial_dash_duration: float = 0.1
@export var camera: Camera2D
@export var can_dash: bool = false
@export var can_wall_jump: bool = false
@export var can_double_jump: bool = false
var coyote_timer: float = 0.0
var dash_timer: float = initial_dash_duration
var is_wall_jumping: bool = false
var is_dashing: bool = false
var first_jump: bool = false
var direction: float
var facing_of: Vector2 = Vector2.RIGHT

func _ready() -> void:
	add_to_group("player")
	
func _process(_delta: float) -> void:
	global_position = global_position.round()

func _physics_process(delta: float) -> void:
	_handle_gravity(delta)
	_handle_jump(delta)
	_handle_movement(delta)
	_handle_dash(delta)
	move_and_slide()
	_update_animation(delta)

func _update_animation(_delta):
	if is_on_floor():
		if _is_moving():
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("idle")
	else:
		if _is_jumping():
			if first_jump:
				if sprite.flip_h:
					$AnimationPlayer.play("jump_facing_left")
				else:
					$AnimationPlayer.play("jump_facing_right")
			else:
				if sprite.flip_h:
					$AnimationPlayer.play("split_jump_left")
				else:
					$AnimationPlayer.play("split_jump_right") 
		elif _is_falling():
			if sprite.flip_h:
				$AnimationPlayer.play("fall_facing_left")
			else: 
				$AnimationPlayer.play("fall_facing_right")
			sprite.rotation_degrees = 360
# Gravidade
func _handle_gravity(delta: float):
	if is_dashing:
		velocity.y = 0
	else:
		if not is_on_floor():
			velocity.y += gravity * delta

# Movimento horizontal
func _handle_movement(delta: float):
	if wall_jump_timer > 0:
		wall_jump_timer -= delta
		return 

	direction = Input.get_axis("left", "right")
	if direction != 0:
		player_direction = direction 
		velocity.x = direction * speed
		if direction < 0:
			sprite.flip_h = true
			facing_of = Vector2.LEFT
		elif direction > 0:
			sprite.flip_h = false
			facing_of = Vector2.RIGHT
	else:
		velocity.x = move_toward(velocity.x, 0, speed * friction)

func _handle_dash(delta: float):
	if can_dash:
		if is_dashing:
			dash_timer -= delta
			if dash_timer <= 0:
				is_dashing = false
				dash_timer = initial_dash_duration
			else:
				velocity.x = dash_force * player_direction
				return
		
		if Input.is_action_just_pressed(Pad.RIGHT_TRIGGER):
			is_dashing = true

# Pulo e wall jump
func _handle_jump(delta: float):
	if is_on_floor():
		coyote_timer = coyote_time
		is_wall_jumping = false
	else:
		coyote_timer -= delta

	if coyote_timer > 0.0 and Input.is_action_just_pressed(Pad.A):
		velocity.y = jump_force
		first_jump = true
		coyote_timer = 0.0
	elif (can_double_jump 
		and first_jump 
		and (_is_jumping() 
		or _is_falling()) 
		and Input.is_action_just_pressed(Pad.A)
	):
		velocity.y = double_jump_force
		first_jump = false
		coyote_timer = 0.0
	
	# Wall jump
	if can_wall_jump:
		if not is_on_floor() and (wall_ray_cast_left.is_colliding() or wall_ray_cast_right.is_colliding()):
			if Input.is_action_just_pressed(Pad.A):
				velocity.y = wall_jump_force
				if wall_ray_cast_left.is_colliding():
					velocity.x = wall_jump_push 
				elif wall_ray_cast_right.is_colliding():
					velocity.x = -wall_jump_push 
				is_wall_jumping = true
				wall_jump_timer = 0.15  

	if Input.is_action_just_released(Pad.A) and _is_jumping():
		velocity.y *= 0.5

func _is_jumping():
	return velocity.y < 0

func _is_falling():
	return velocity.y > 0 and not is_on_floor()

func _is_moving():
	return abs(velocity.x) > 0.1

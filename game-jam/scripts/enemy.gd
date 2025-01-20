class_name Enemy
extends CharacterBody2D

signal on_enemy_killed

enum NavigationMode {SIMPLE_DIRECTION, ASTAR}
enum Direction {UP, RIGHT, DOWN, LEFT}

# On ready
@onready var until_next_damage : Timer = %Timer
@onready var animated_sprite_2d : AnimatedSprite2D = %AnimatedSprite2D
@onready var animation_player : AnimationPlayer = %AnimationPlayer
@onready var navigation_agent : NavigationAgent2D = %NavigationAgent2D

# Enemy Info
@export_category("Enemy Info")
@export var enemy_info : EnemyInfo
var max_health : int
var speed : float
var acceleration : float = 7

# Navigation
var navigation_mode: NavigationMode = NavigationMode.SIMPLE_DIRECTION
var direction: Direction = Direction.UP
var target: Node2D

# Flags
var is_damageable : bool = true
var is_dying : bool = false

func _ready() -> void:

	max_health = enemy_info.max_health
	speed = enemy_info.max_speed
	until_next_damage.timeout.connect(_on_timeout)
	
	animated_sprite_2d.sprite_frames = enemy_info.sprite_frames
	animated_sprite_2d.animation = "idle"
	animated_sprite_2d.play()
	
	# Waiting for map to setup agent
	set_physics_process(false)
	await get_tree().physics_frame
	set_physics_process(true)
	
	call_deferred("_agent_setup")

func _agent_setup() -> void:
	if navigation_mode == NavigationMode.ASTAR:
		navigation_agent.target_position = target.global_position

func _physics_process(delta: float):
	if !is_dying:
		var direction_vector : Vector2 = Vector2.ZERO
		if navigation_mode == NavigationMode.SIMPLE_DIRECTION:
			if direction == Direction.UP:
				direction_vector = Vector2.UP
			elif direction == Direction.RIGHT:
				direction_vector = Vector2.RIGHT
			elif direction == Direction.DOWN:
				direction_vector = Vector2.DOWN
			elif direction == Direction.LEFT:
				direction_vector = Vector2.LEFT
		elif navigation_mode == NavigationMode.ASTAR:
			direction_vector = navigation_agent.get_next_path_position() - global_position
			direction_vector = direction_vector.normalized()
		
		velocity = velocity.lerp(direction_vector * speed, acceleration * delta)
		move_and_slide()

func hit() -> void: 
	max_health -= 1
	is_damageable = false
	until_next_damage.start()
	animated_sprite_2d.animation = "die"
	animated_sprite_2d.play()
	if (max_health == 0):
		is_dying = true
		on_enemy_killed.emit()
		animation_player.current_animation = "die"
		animation_player.play()
		
func _on_timeout() -> void:
	is_damageable = true
	animated_sprite_2d.animation = "idle"
	animated_sprite_2d.play()
	

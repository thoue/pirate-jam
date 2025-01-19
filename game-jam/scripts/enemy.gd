class_name Enemy
extends Node2D

signal on_enemy_killed

@onready var until_next_damage : Timer = %Timer
@onready var animated_sprite_2d : AnimatedSprite2D = %AnimatedSprite2D
@onready var animation_player : AnimationPlayer = %AnimationPlayer

@export var enemy_info: EnemyInfo
var max_health
var is_damageable : bool = true
var is_dying : bool = false

func _ready() -> void:
	max_health = enemy_info.max_health
	until_next_damage.timeout.connect(_on_timeout)
	
	animated_sprite_2d.sprite_frames = enemy_info.sprite_frames
	animated_sprite_2d.animation = "idle"
	animated_sprite_2d.play()

func _process(delta: float):
	if !is_dying:
		position.x += -1 * enemy_info.max_speed * delta

func _on_area_entered(area: Area2D) -> void:
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
	

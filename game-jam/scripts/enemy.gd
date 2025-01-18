class_name Ennemy
extends Area2D

@onready var until_next_damage : Timer = %Timer
@export var stats: EnemyStats
@onready var animation_player = $AnimationPlayer
var max_health
var is_damageable : bool = true

func _ready() -> void:
	max_health = stats.max_health
	until_next_damage.timeout.connect(_on_timeout)

func _process(delta: float):
	position.x += -1 * stats.max_speed * delta

func _on_area_entered(area: Area2D) -> void:
	max_health -= 1
	print(max_health)
	is_damageable = false
	until_next_damage.start()
	if (max_health == 0):
		queue_free()
		
func _on_timeout() -> void:
	is_damageable = true
	

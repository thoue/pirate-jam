class_name Enemy
extends Node2D

signal on_enemy_killed

@onready var until_next_damage : Timer = %Timer
@export var stats: EnemyStats
var max_health
var is_damageable : bool = true

func _ready() -> void:
	max_health = stats.max_health
	until_next_damage.timeout.connect(_on_timeout)

func _process(delta: float):
	position.x += -1 * stats.max_speed * delta

func _on_area_entered(area: Area2D) -> void:
	max_health -= 1
	is_damageable = false
	until_next_damage.start()
	if (max_health == 0):
		on_enemy_killed.emit()
		queue_free()
		
func _on_timeout() -> void:
	is_damageable = true
	

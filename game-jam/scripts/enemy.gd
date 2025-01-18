extends Node2D

@onready var until_next_damage : Timer = %Timer
@export var stats: EnemyStats

var is_damageable : bool = true

func _ready() -> void:
	until_next_damage.timeout.connect(_on_timeout)

func _process(delta: float):
	position.x += -1 * stats.max_speed * delta

func _on_area_entered(area: Area2D) -> void:
	print("area entered")
	stats.max_health -= 1
	is_damageable = false
	until_next_damage.start()
	if (stats.max_health == 0):
		queue_free()
		
func _on_timeout() -> void:
	is_damageable = true
	

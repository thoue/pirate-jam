extends Node2D

@export var stats: EnemyStats

func _process(delta: float):
	position.x += -1 * stats.max_speed * delta




func _on_area_entered(area: Area2D) -> void:
	stats.max_health -= 1
	if (stats.max_health == 0):
		queue_free()
		

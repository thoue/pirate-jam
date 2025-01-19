extends Area2D
signal on_base_destroyed

var health = 100
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var score = $ProgressBar

func _on_area_entered(area: Area2D) -> void:
	health -= area.stats.damage
	score.value = health
	area.queue_free()
	
	if (health <= 0):
		on_base_destroyed.emit()
	

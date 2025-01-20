extends Area2D
signal on_base_destroyed

var health = 100
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var score = $ProgressBar

func _on_body_entered(body: Node2D) -> void:
	health -= body.enemy_info.damage
	score.value = health
	body.die()
	
	if (health <= 0):
		on_base_destroyed.emit()

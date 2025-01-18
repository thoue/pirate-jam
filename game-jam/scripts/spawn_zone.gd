extends Area2D

@export var spawn_area : CollisionShape2D

func spawn_ennemies(ennemy : ) -> void:

func get_random_position_in_area() -> Vector2:
	if !spawn_area:
		push_error("Expected a Spawn Area (CollisionShape2D).")
	
	var random_position : Vector2
	if spawn_area.shape is RectangleShape2D:
		var rect : RectangleShape2D = spawn_area.shape
		var x = randf_range(0, rect.size.x)
		var y = randf_range(0, rect.size.y)
		random_position = Vector2(x, y)
	else:
		push_error("Spawn Area Shape Type not supported.")
	return random_position

class_name SpawnZone
extends Area2D

@export var spawn_area : CollisionShape2D
@export var enemies_node : Node

func spawn_ennemies(scene : PackedScene, nb_enemies : int) -> Array[Enemy]:
	var enemies_spawned : Array[Enemy] = []
	for i in range(nb_enemies):
		var enemy = scene.instantiate() as Enemy
		enemies_spawned.append(enemy)
		var enemy_pos = _get_random_position_in_area()
		enemies_node.add_child(enemy)
		enemy.position = enemy_pos
	
	return enemies_spawned

func _get_random_position_in_area() -> Vector2:
	if !spawn_area:
		push_error("Expected a Spawn Area (CollisionShape2D).")
	
	var random_position : Vector2
	if spawn_area.shape is RectangleShape2D:
		var rect : RectangleShape2D = spawn_area.shape
		var x = (randf_range(0, rect.size.x/2) * random_sign()) + spawn_area.global_position.x
		var y = (randf_range(0, rect.size.y/2) * random_sign())  + spawn_area.global_position.y
		random_position = Vector2(x, y)
	else:
		push_error("Spawn Area Shape Type not supported.")
	return random_position

func random_sign() -> int:
	if randf() < 0.5: 
		return -1
	return 1

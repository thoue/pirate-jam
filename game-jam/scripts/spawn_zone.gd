@tool
class_name SpawnZone
extends Area2D

enum NavigationMode {SIMPLE_DIRECTION, ASTAR}
enum Direction {UP, RIGHT, DOWN, LEFT}

@export var spawn_area : CollisionShape2D
@export var enemies_node : Node

@export_category("Navigation Mode")
@export var navigation_mode: NavigationMode = NavigationMode.SIMPLE_DIRECTION:
	set(value):
		navigation_mode = value
		notify_property_list_changed()
@export var direction: Direction = Direction.UP
@export var target: Node2D

func spawn_ennemies(scene : PackedScene, nb_enemies : int) -> Array[Enemy]:
	var enemies_spawned : Array[Enemy] = []
	for i in range(nb_enemies):
		var enemy = scene.instantiate() as Enemy
		
		# Set navigation properties from spawn zone
		enemy.navigation_mode = navigation_mode
		enemy.direction = direction
		enemy.target = target
		
		# Calculate initial position of enemy and set it
		var enemy_pos = _get_random_position_in_area()
		enemies_node.call_deferred("add_child", enemy)
		enemy.position = enemy_pos

		enemies_spawned.append(enemy)
	
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

func _validate_property(property: Dictionary) -> void:
	if property.name == "direction" and navigation_mode != NavigationMode.SIMPLE_DIRECTION:
		property.usage = PROPERTY_USAGE_NO_EDITOR
	elif property.name == "target" and navigation_mode != NavigationMode.ASTAR:
		property.usage = PROPERTY_USAGE_NO_EDITOR

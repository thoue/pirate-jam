extends Node

@export var waves : Array[EnemyWave]
@export var spawn_zones : Array[SpawnZone]

var enemies_on_map : int = 0
var wave_index : int = 0

func _ready() -> void:
	_start_next_round()

func _on_base_destroyed() -> void:
	print("base destroyed")
	pass # GAME OVER

func _on_ennemy_killed() -> void:
	enemies_on_map -= 1
	if enemies_on_map <= 0:
		_start_next_round()

func _start_next_round() -> void:
	if wave_index == waves.size():
		print("GG")
		return
	
	var current_wave = waves[wave_index]
	var scenes = current_wave.scenes
	var number_of_enemies = current_wave.number_of_enemies
	
	if scenes.size() != number_of_enemies.size():
		push_error("EnemyWave is not set properly.")
	
	enemies_on_map = 0
	for x in number_of_enemies:
		enemies_on_map += x
	print(enemies_on_map)
	
	for i in range(scenes.size()):
		var random = randi_range(0, spawn_zones.size() - 1)
		var enemies_spawned = spawn_zones[random].spawn_ennemies(scenes[i], number_of_enemies[i])
		
		for enemy in enemies_spawned:
			enemy.on_enemy_killed.connect(_on_ennemy_killed)
	
	wave_index += 1

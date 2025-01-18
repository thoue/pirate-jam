extends Node

@export var base : Node2D
@export var waves : Array # Array of arrays of ennemies
@export var spawn_zones : Array[Node2D]

var nb_of_ennemies : int = 0
var wave_index : int = 0

func _ready() -> void:
	# Connect to signal when on_base_destroyed
	pass

func _on_base_destroyed() -> void:
	pass # GAME OVER

func _on_ennemy_killed() -> void:
	nb_of_ennemies -= 1
	if nb_of_ennemies <= 0:
		_start_next_round()

func _start_next_round() -> void:
	if wave_index == waves.size():
		pass # GG!
	
	# Spawn randomly in spawn zones.

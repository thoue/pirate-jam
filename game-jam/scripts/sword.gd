extends Area2D

@export var damage : int = 1
@export var speed : int = 10

var mouse_changed : bool = false
var target_position : Vector2

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	_handle_sword_movement(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		target_position = get_global_mouse_position()
		mouse_changed = true

func _handle_sword_movement(delta) -> void: 
	if mouse_changed: 
		position = position.lerp(target_position, delta * speed)
		look_at(target_position)
		if position == target_position:
			mouse_changed = false

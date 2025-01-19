extends Area2D

@export var damage : int = 1
@export var speed : int = 10
@export var distance_to_mouse : int = 10

var mouse_changed : bool = false
var target_position : Vector2


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	_handle_sword_movement(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		target_position = get_global_mouse_position()
		if position.distance_to(target_position) >= distance_to_mouse:
			mouse_changed = true

func _handle_sword_movement(delta : float) -> void: 
	if mouse_changed: 
		_handle_translation(delta) 
	_handle_rotation()

func _handle_translation(delta : float) -> void:
	position = position.lerp(target_position, delta * speed)
	if position.distance_to(target_position) < distance_to_mouse:
		mouse_changed = false

func _handle_rotation() -> void: 
	var rot = rotation_degrees
	look_at(target_position)
	var target_rot = rotation_degrees
	rotation_degrees = lerpf(rot, target_rot, 0.3)

func _on_body_entered(body: Node2D) -> void:
	if body.is_damageable:
		body.hit()

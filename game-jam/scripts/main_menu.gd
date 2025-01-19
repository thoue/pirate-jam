extends Control

@onready var audio := $AudioStreamPlayer2D
	

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")
	audio.stop()

func _on_quit_button_pressed() -> void:
	audio.stop()
	get_tree().quit()

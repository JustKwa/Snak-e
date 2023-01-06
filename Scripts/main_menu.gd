extends Control

onready var game = preload("res://Scenes/level.tscn")
func _ready():
	return


func _on_start_button_pressed():
	return get_tree().change_scene("res://Scenes/level.tscn")


func _on_exit_button_pressed():
	get_tree().quit()


func _spawn_game():
	var instance = game.instance()
	call_deferred("add_child", instance)


func _queue_free():
	queue_free()

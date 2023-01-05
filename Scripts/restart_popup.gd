extends CanvasLayer

onready var global_var = preload("res://global_var.tres")


func _ready():
	$Control/Label.text = """
	Press any key to play again
	Score: {score}
	High score: {high_score}
	""".format(
		{"score": global_var.player_score, "high_score": global_var.high_score}
	)


func _input(event):
	if not event is InputEventKey:
		return

	if event.pressed:
		global_var.game_over = false
		global_var.player_score = 0
		get_tree().paused = false
		return get_tree().reload_current_scene()

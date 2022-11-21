extends CanvasLayer


func _ready():
	$Control/Label.text = """
	Press any key to play again
	Score: {score}
	High score: {high_score}
	""".format({"score": score.player_score, "high_score": score.high_score})


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			score.game_over = false
			get_tree().paused = false
			return get_tree().reload_current_scene()

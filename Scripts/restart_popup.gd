extends CanvasLayer


func _ready():
	$Control/Label.text = """
	Press \"R\" to play again
	Score: {score}
	High score: {high_score}
	""".format({"score": score.player_score, "high_score": score.high_score})


func _process(_delta):
	if Input.is_action_just_pressed('ui_restart'):
		get_tree().paused = false
		return get_tree().reload_current_scene()

extends CanvasLayer

onready var global_var = preload('res://global_var.tres')

func _ready():
	$Control/Label.text = """
	Press any key to play again
	Score: {score}
	High score: {high_score}
	""".format({"score": global_var.player_score, "high_score": global_var.high_score})


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			score.game_over = false
			get_tree().paused = false
			return get_tree().reload_current_scene()

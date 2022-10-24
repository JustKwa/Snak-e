extends Control

onready var score_board = $Label


func _ready():
	score_board.set_text("Score: %s" % score.player_score)


func _process(_delta):
	score_board.set_text("Score: %s" % score.player_score)

extends Control

onready var global_var = preload('res://global_var.tres')
onready var score_board = $Label


func _ready():
	score_board.set_text("Score: %s" % global_var.player_score)
	global_var.connect('score_gained', self, '_on_score_gained')

func _on_score_gained():
	score_board.set_text("Score: %s" % global_var.player_score)

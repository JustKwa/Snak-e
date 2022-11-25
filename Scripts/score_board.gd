extends Control

onready var global_var = preload('res://global_var.tres')
onready var score_board = $Label


func _ready():
	score_board.set_text("Score: %s" % global_var.player_score)


func _process(_delta):
	score_board.set_text("Score: %s" % global_var.player_score)

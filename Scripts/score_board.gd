extends TextureRect

onready var global_var = preload("res://global_var.tres")
onready var score_board = $score_number


func _ready():
	global_var.connect("score_gained", self, "_on_score_gained")


func _on_score_gained():
	score_board.set_text("%010d" % global_var.player_score)

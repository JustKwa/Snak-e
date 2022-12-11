class_name GlobalVar
extends Resource

signal game_over
signal score_gained

const GRID_SIZE = 16

var player_score: int = 0 setget _set_score
var high_score: int = 0 setget _set_high_score
var game_over: bool = false setget _set_game_over
var speed: float


func _set_score(value):
	player_score = value
	emit_signal("score_gained")


func _set_game_over(value):
	if value:
		emit_signal("game_over")


func _set_high_score(value):
	if value > high_score:
		high_score = value

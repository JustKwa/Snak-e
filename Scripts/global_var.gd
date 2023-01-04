class_name GlobalVar
extends Resource

signal next_level
signal game_over
signal score_gained

const GRID_SIZE = 32

var player_score: int = 0 setget _set_score
var high_score: int = 0 setget _set_high_score
var game_over: bool = false setget _set_game_over
var speed: float
var food_required_for_next_level: int = 0
var current_food_has: int = 0 


func _set_score(value):
	player_score = value
	emit_signal("score_gained")


func _set_game_over(value):
	if value:
		emit_signal("game_over")


func _set_high_score(value: int):
	if value > high_score:
		high_score = value


func increase_current_food_has():
	current_food_has += 1
	if current_food_has < food_required_for_next_level:
		return
	current_food_has = 0
	emit_signal("next_level")

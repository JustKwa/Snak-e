class_name GlobalVar
extends Resource

signal next_level
signal game_over
signal score_gained

const GRID_SIZE = 32

export var speed: float

var player_score: int = 0 setget _set_score
var high_score: int = 0 setget _set_high_score
var game_over: bool = false setget _set_game_over
var food_required_for_next_level: int = 0
var _current_food_has: int = 0
var is_transitioning: bool = false


func _set_score(value):
	player_score = value
	emit_signal("score_gained")


func _set_game_over(value):
	if !value:
		return
	high_score = player_score
	_current_food_has = 0
	emit_signal("game_over")


func _set_high_score(value: int):
	if value > high_score:
		high_score = value


func increase_current_food_has():
	_current_food_has += 1
	if _current_food_has < food_required_for_next_level:
		return

	_current_food_has = 0
	is_transitioning = true
	emit_signal("next_level")


func test_signal():
	emit_signal("next_level")

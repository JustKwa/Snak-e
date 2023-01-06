class_name GlobalVar
extends Resource

signal next_level
signal game_over
signal score_gained
signal high_score

const GRID_SIZE = 32

export var speed: float

var player_score: int = 0 setget setscore
export var high_score: int setget _set_high_score
var game_over: bool = false setget _set_game_over
var food_required_for_next_level: int = 0
var _current_food_has: int = 0
var is_transitioning: bool = false
var multiplier = 1


func _set_game_over(value):
	if !value:
		return
	_current_food_has = 0
	multiplier = 1
	emit_signal("game_over")


func _set_high_score(value: int):
	if player_score >= value:
		return

	high_score = value
	emit_signal("high_score")


func increase_current_food_has():
	_current_food_has += 1
	if _current_food_has < food_required_for_next_level:
		return

	_current_food_has = 0
	is_transitioning = true
	multiplier += 1
	emit_signal("next_level")


func test_signal():
	emit_signal("next_level")


func increase_score():
	player_score += 1 * multiplier
	high_score = player_score
	emit_signal("score_gained")


func setscore(value):
	player_score = value
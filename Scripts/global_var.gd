class_name global_var
extends Resource

const GRID_SIZE = 16

var player_score: int = 0
var high_score: int = 0
var game_over: bool = false setget _set_game_over
var speed: float

signal game_over

func _set_game_over(value):
    if !value: return
    else:
        emit_signal('game_over')
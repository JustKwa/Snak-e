extends Resource
class_name LevelSheet

export(Array, Dictionary) var _level_sheet = [{
    "id": 0,
    "food_required": 0,
    "food_amount": 0,
    "food_timer": 0.0,
    "speed_modifier": 0.0,
    "canon_timer": 0.0
}
]

export var current_level: int = 0 setget _set_level, _get_level


func _set_level(value: int):
    current_level = value 


func _get_level():
    return _level_sheet[current_level]
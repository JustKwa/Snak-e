extends Resource
class_name LevelSheet

export(Array, Dictionary) var _level_sheet = []


func get_level(id: int):
    return _level_sheet[id]


func get_food_required(id: int):
    return _level_sheet[id].get("food_required")


func get_food_amount(id: int):
    return _level_sheet[id].get("food_amount")


func get_canon_timer(id: int):
    return _level_sheet[id].get("canon_timer")


func get_speed_modifier(id: int):
    return _level_sheet[id].get("speed_modifier")


func get_bomb_timer(id: int):
    return _level_sheet[id].get("bomb_timer")
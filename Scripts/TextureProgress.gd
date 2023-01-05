extends TextureProgress

onready var global_var = preload("res://global_var.tres")
onready var level_sheet = preload("res://resources/level_sheet.tres")


func _ready():
	global_var.connect("score_gained", self, "_on_score_gained")
	global_var.connect("next_level", self, "_on_next_level")


func _on_score_gained():
	self.value += 1


func _on_next_level():
	self.value = 0
	self.max_value = global_var.food_required_for_next_level


func _on_level_game_start():
	self.max_value = global_var.food_required_for_next_level
	self.value = 0

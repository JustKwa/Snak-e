class_name SnakeBody
extends Area2D

const GRID_SIZE = GlobalVar.GRID_SIZE

var direction = Vector2.RIGHT
var percent_to_tile = 0.0
var state

onready var level_sheet = preload("res://resources/level_sheet.tres")
onready var global_var = preload("res://global_var.tres")
onready var current_pos = self.position
onready var animation_player = get_node("AnimationPlayer")

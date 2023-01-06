extends ColorRect

signal visible(value)

onready var global_var = preload("res://global_var.tres")


func _ready():
	global_var.connect("next_level", self, "_on_next_level")


func _on_Line2D_shoot_time():
	$AnimationPlayer.play("alert_on")
	emit_signal("visible",false)


func _on_next_level():
	$AnimationPlayer.play("alert_off")
	emit_signal("visible",true)

func _on_Line2D_shoot():
	$AnimationPlayer.play("alert_off")
	emit_signal("visible",true)

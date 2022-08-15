extends Node2D


func _ready():
	$Tween.interpolate_property($Area2D, "position", $Area2D.position, Vector2(100, 100), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0 )
	$Tween.start()
	pass
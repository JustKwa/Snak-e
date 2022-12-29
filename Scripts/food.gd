extends SpawnItem

signal food_eaten
signal food_explode(position)

enum State { IDLE, EXPLODE, EATEN, DELETE}

var state = State.IDLE
export var wait_time: int 

onready var global_var = preload("res://global_var.tres")
onready var animation_player = $food_area/AnimationPlayer
onready var collision_shape = $food_area/CollisionShape2D


func _ready():
	$Timer.set_wait_time(wait_time)
	$Timer.start()


func _physics_process(_delta):
	match state:
		State.IDLE:
			_idle()
			return
		State.EXPLODE:
			_explode()
			emit_signal("food_explode", self.position)
			state = State.IDLE
			return
		State.EATEN:
			_eaten()
			_queue_free()


func _queue_free():
	emit_signal("despawned", self.position)
	queue_free()


func _idle():
	return


func _explode():
	collision_shape.set_deferred("disabled", true)
	animation_player.play("explode")


func _eaten():
	global_var.player_score += 1
	emit_signal("food_eaten")


func _on_Area2D_area_entered(area: Area2D):

	if global_var.game_over:
		return

	if area.is_in_group("eat_food"):
		state = State.EATEN
		return

	if area.is_in_group("food_explode"):
		state = State.EXPLODE
		return


func _on_Timer_timeout():
	state = State.EXPLODE

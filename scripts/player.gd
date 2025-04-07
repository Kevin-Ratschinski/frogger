class_name Player extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal new_max_row_reached

var start_position: Vector2 = Vector2(304, 338)
var step_size: int = 32
var current_row: int = 0
var max_row : int = 0

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		move_up()
	elif Input.is_action_just_pressed("move_down"):
		move_down()
	elif Input.is_action_just_pressed("move_left"):
		move_left()
	elif Input.is_action_just_pressed("move_right"):
		move_right()
	
	if current_row > max_row:
		max_row = current_row
		new_max_row_reached.emit()

func move_up() -> void:
	var next_step := global_position.y - step_size
	if next_step < 0:
		return
	move_and_collide(Vector2(0, -step_size))
	animation_player.play("jump_up")
	current_row += 1

func move_down() -> void:
	var next_step := global_position.y + step_size
	if next_step > get_viewport_rect().size.y:
		return
	move_and_collide(Vector2(0, step_size))
	animation_player.play("jump_down")
	current_row -= 1

func move_left() -> void:
	var next_step := global_position.x - step_size
	if next_step < 0:
		return
	move_and_collide(Vector2(-step_size, 0))
	animation_player.play("jump_left")

func move_right() -> void:
	var next_step := global_position.x + step_size
	if next_step > get_viewport_rect().size.x:
		return
	move_and_collide(Vector2(step_size, 0))
	animation_player.play("jump_right")

func reset_player():
	global_position = start_position
	current_row = 0
	max_row = 0

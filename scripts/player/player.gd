class_name Player extends CharacterBody2D

@export var GRACE_PERIOD_TIME: int = 50

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal new_max_row_reached
signal game_over

enum SafetyState { UNSAFE, SAFE, GRACE_PERIOD }
var safety_state := SafetyState.UNSAFE

var start_position: Vector2 = Vector2(304, 338)
var step_size: int = 32
var current_row: int = 0
var max_row: int = 0

# private variables
var _safe_until_time := 0

func _process(_delta: float) -> void:
	if safety_state == SafetyState.GRACE_PERIOD:
		if Time.get_ticks_msec() > _safe_until_time:
			print("Set Player State: UNSAFE")
			safety_state = SafetyState.UNSAFE
	
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

func reset(decrease_life: bool = true):
	set_process(false)
	await get_tree().create_timer(0.2).timeout
	
	if decrease_life:
		Global.lives -= 1
	
	if Global.lives > 0:
		global_position = start_position
		current_row = 0
		max_row = 0
		await get_tree().create_timer(0.2).timeout
		safety_state = SafetyState.UNSAFE
		set_process(true)
	else:
		game_over.emit()
		queue_free()

func update_safety_status(new_status: bool):
	if new_status:
		safety_state = SafetyState.SAFE
		print("Set Player State: SAFE")
		_safe_until_time = Time.get_ticks_msec() + GRACE_PERIOD_TIME
	else:
		if safety_state == SafetyState.SAFE:
			print("Set Player State: GRACE_PERIOD")
			safety_state = SafetyState.GRACE_PERIOD

func is_player_safe() -> bool:
	return safety_state != SafetyState.UNSAFE

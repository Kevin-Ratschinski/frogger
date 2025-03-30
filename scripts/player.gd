extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var step_size: int = 32

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		move_and_collide(Vector2(0, -step_size))
		animation_player.play("jump_up")
	elif Input.is_action_just_pressed("move_down"):
		move_and_collide(Vector2(0, step_size))
		animation_player.play("jump_down")
	elif Input.is_action_just_pressed("move_left"):
		move_and_collide(Vector2(-step_size, 0))
		animation_player.play("jump_left")
	elif Input.is_action_just_pressed("move_right"):
		move_and_collide(Vector2(step_size, 0))
		animation_player.play("jump_right")

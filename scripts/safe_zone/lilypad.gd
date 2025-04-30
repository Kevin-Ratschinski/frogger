class_name Lilypad extends Node2D


@onready var lilypad_sprite: Sprite2D = $LilypadSprite2D
@onready var goal_frog_sprite: Sprite2D = $GoalFrogSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal lilypad_reached

enum LilypadState { EMPTY, FULL }
var lilypad_state: LilypadState = LilypadState.EMPTY

# float variables for sine wave movement
var float_amplitude: float = 1.5
var float_speed: float = 1.1
var float_phase: float = 0.0

func _ready() -> void:
	float_phase = randf() * TAU
	goal_frog_sprite.visible = false

func _process(delta: float) -> void:
	position.y += sin(Time.get_ticks_msec() / 1000.0 * float_speed + float_phase) * float_amplitude * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and lilypad_state == LilypadState.EMPTY:
		var player := body
		handle_player_on_lilypad(player)
		lilypad_state = LilypadState.FULL
		lilypad_reached.emit()

func handle_player_on_lilypad(player: Player) -> void:
	player.visible = false
	goal_frog_sprite.visible = true
	animation_player.play("rotate_frog")
	lilypad_state = LilypadState.FULL
	player.reset(false)

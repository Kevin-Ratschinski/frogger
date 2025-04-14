class_name Lilypad extends Node2D


@onready var lilypad_sprite: Sprite2D = $LilypadSprite2D
@onready var goal_frog_sprite: Sprite2D = $GoalFrogSprite2D

enum LilypadState { EMPTY, FULL }
var lilypad_state: LilypadState = LilypadState.EMPTY

func _ready() -> void:
	goal_frog_sprite.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var player := body
		handle_player_on_lilypad(player)

func handle_player_on_lilypad(player: Player) -> void:
	goal_frog_sprite.visible = true
	lilypad_state = LilypadState.FULL
	player.reset(false)
